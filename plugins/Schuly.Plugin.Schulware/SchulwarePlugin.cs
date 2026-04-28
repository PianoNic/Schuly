using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Kiota.Abstractions.Authentication;
using Microsoft.Kiota.Http.HttpClientLibrary;
using Schuly.Plugin.Abstractions;
using Schuly.Plugin.Schulware.Client;
using Schuly.Plugin.Schulware.Client.Models;
using Schuly.Plugin.Schulware.Data;
using System.Net.Http.Json;

namespace Schuly.Plugin.Schulware
{
    public class SchulwarePlugin : ISchulyPlugin
    {
        public string Name => "Schulware Integration";
        public string Version => "2.0.0";

        public void ConfigureServices(IServiceCollection services, PluginServiceContext context)
        {
            services.AddDbContext<SchulwareDbContext>(options =>
                options.UseNpgsql(context.ConnectionString));

            services.AddSingleton<IPluginBackgroundTask, SchulwareSyncTask>();
        }

        public void ConfigureEndpoints(IEndpointRouteBuilder endpoints)
        {
            endpoints.MapGet("/api/plugins/schulware/status", () =>
                Results.Ok(new { Status = "Active", Plugin = Name, Version })
            ).AllowAnonymous();

            endpoints.MapGet("/api/plugins/schulware/accounts", async (
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var accounts = await db.Accounts
                    .Where(a => a.ApplicationUserId == userId)
                    .Select(a => new
                    {
                        a.Id, a.SchulnetzBaseUrl, a.DisplayName, a.SchulnetzStudentId,
                        a.SchoolUserId, HasMobileToken = a.MobileAccessToken != null,
                        HasWebSession = a.WebSessionId != null, a.MobileTokenExpiresAt, a.CreatedAt
                    })
                    .ToListAsync();
                return Results.Ok(accounts);
            }).RequireAuthorization();

            endpoints.MapPost("/api/plugins/schulware/accounts", async (
                ConnectAccountRequest request,
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();

                var exists = await db.Accounts.AnyAsync(a =>
                    a.ApplicationUserId == userId && a.SchulnetzBaseUrl == request.SchulnetzBaseUrl);
                if (exists)
                    return Results.BadRequest("Account for this Schulnetz instance already connected");

                var account = new SchulwareAccount
                {
                    ApplicationUserId = userId,
                    SchulnetzBaseUrl = request.SchulnetzBaseUrl,
                    SchulwareApiBaseUrl = request.SchulwareApiBaseUrl ?? "https://schlwr.pianonic.ch",
                    DisplayName = request.DisplayName,
                    SchoolUserId = request.SchoolUserId,
                };
                db.Accounts.Add(account);
                await db.SaveChangesAsync();

                return Results.Ok(new { account.Id, Message = "Account created. Authenticate next." });
            }).RequireAuthorization();

            endpoints.MapDelete("/api/plugins/schulware/accounts/{accountId:guid}", async (
                Guid accountId,
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var account = await db.Accounts.FirstOrDefaultAsync(a => a.Id == accountId && a.ApplicationUserId == userId);
                if (account is null) return Results.NotFound();

                var syncState = await db.SyncStates.FirstOrDefaultAsync(s => s.AccountId == accountId);
                if (syncState is not null) db.SyncStates.Remove(syncState);

                db.Accounts.Remove(account);
                await db.SaveChangesAsync();
                return Results.NoContent();
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/schulware/accounts/{accountId:guid}/auth/oauth/url", async (
                Guid accountId,
                IPluginUserContext userContext,
                SchulwareDbContext db,
                IHttpClientFactory httpClientFactory) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var account = await db.Accounts.FirstOrDefaultAsync(a => a.Id == accountId && a.ApplicationUserId == userId);
                if (account is null) return Results.NotFound();

                var client = CreateClient(httpClientFactory, account.SchulwareApiBaseUrl);
                var result = await client.Api.Authenticate.Oauth.Mobile.Url.GetAsync();
                return Results.Ok(result);
            }).RequireAuthorization();

            endpoints.MapPost("/api/plugins/schulware/accounts/{accountId:guid}/auth/oauth/callback", async (
                Guid accountId,
                OAuthCallbackRequest request,
                IPluginUserContext userContext,
                SchulwareDbContext db,
                IHttpClientFactory httpClientFactory,
                Schuly.Infrastructure.SchulyDbContext mainDb) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var account = await db.Accounts.FirstOrDefaultAsync(a => a.Id == accountId && a.ApplicationUserId == userId);
                if (account is null) return Results.NotFound();

                using var httpClient = httpClientFactory.CreateClient("Schulware");

                // 1. Exchange code for tokens
                var callbackRes = await httpClient.PostAsJsonAsync(
                    $"{account.SchulwareApiBaseUrl}/api/authenticate/oauth/mobile/callback",
                    new { code = request.Code, code_verifier = request.CodeVerifier, state = request.State });

                if (!callbackRes.IsSuccessStatusCode)
                    return Results.BadRequest($"OAuth callback failed: {await callbackRes.Content.ReadAsStringAsync()}");

                var tokenResult = await callbackRes.Content.ReadFromJsonAsync<TokenResponse>();
                if (tokenResult is null)
                    return Results.BadRequest("Failed to parse token response");

                account.MobileAccessToken = tokenResult.AccessToken;
                account.MobileRefreshToken = tokenResult.RefreshToken;
                account.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);

                // 2. Capture web session
                var captureRes = await httpClient.PostAsJsonAsync(
                    $"{account.SchulwareApiBaseUrl}/api/websession/capture",
                    new { code = request.Code, state = request.State ?? "" });

                if (captureRes.IsSuccessStatusCode)
                {
                    var sessionResult = await captureRes.Content.ReadFromJsonAsync<System.Text.Json.JsonElement>();
                    if (sessionResult.TryGetProperty("success", out var success) && success.GetBoolean())
                    {
                        account.WebSessionId = sessionResult.TryGetProperty("session_id", out var sid) ? sid.GetString() : null;
                        if (sessionResult.TryGetProperty("session_info", out var info) && info.ValueKind == System.Text.Json.JsonValueKind.Object)
                        {
                            account.WebSessionUserId = info.TryGetProperty("id", out var id) ? id.GetString() : null;
                            account.WebSessionTransId = info.TryGetProperty("transid", out var tid) ? tid.GetString() : null;
                        }
                    }
                }

                // 3. Fetch user info and auto-provision School + SchoolUser
                if (account.SchoolUserId is null && account.MobileAccessToken is not null)
                {
                    try
                    {
                        httpClient.DefaultRequestHeaders.Authorization =
                            new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", account.MobileAccessToken);

                        var userInfoRes = await httpClient.GetAsync($"{account.SchulwareApiBaseUrl}/api/mobile/userInfo");
                        if (userInfoRes.IsSuccessStatusCode)
                        {
                            var userInfo = await userInfoRes.Content.ReadFromJsonAsync<System.Text.Json.JsonElement>();

                            var schoolName = account.DisplayName ?? account.SchulnetzBaseUrl;
                            var school = await mainDb.Schools.FirstOrDefaultAsync(s => s.Name == schoolName);
                            if (school is null)
                            {
                                school = new Schuly.Domain.School { Name = schoolName };
                                mainDb.Schools.Add(school);
                                await mainDb.SaveChangesAsync();
                            }

                            var firstName = userInfo.TryGetProperty("firstName", out var fn) ? fn.GetString() ?? "" : "";
                            var lastName = userInfo.TryGetProperty("lastName", out var ln) ? ln.GetString() ?? "" : "";
                            var email = userInfo.TryGetProperty("email", out var em) ? em.GetString() ?? "" : "";
                            var studentId = userInfo.TryGetProperty("idNr", out var idNr) ? idNr.GetString() : null;
                            var birthday = userInfo.TryGetProperty("birthday", out var bd) ? bd.GetString() : null;
                            var entryDate = userInfo.TryGetProperty("entryDate", out var ed) ? ed.GetString() : null;

                            var schoolUser = await mainDb.SchoolUsers
                                .FirstOrDefaultAsync(su => su.ApplicationUserId == userId && su.SchoolId == school.Id);

                            if (schoolUser is null)
                            {
                                schoolUser = new Schuly.Domain.SchoolUser
                                {
                                    ApplicationUserId = userId,
                                    SchoolId = school.Id,
                                    FirstName = firstName,
                                    LastName = lastName,
                                    Email = email,
                                    Birthday = DateOnly.TryParse(birthday, out var bd2) ? bd2 : DateOnly.FromDateTime(DateTime.UtcNow),
                                    EntryDate = DateOnly.TryParse(entryDate, out var ed2) ? ed2 : DateOnly.FromDateTime(DateTime.UtcNow),
                                    Role = Schuly.Domain.Enums.Roles.Student,
                                };
                                mainDb.SchoolUsers.Add(schoolUser);
                                await mainDb.SaveChangesAsync();
                            }

                            account.SchoolUserId = schoolUser.Id;
                            account.SchulnetzStudentId = studentId;
                        }
                    }
                    catch { }
                }

                account.UpdatedAt = DateTime.UtcNow;
                await db.SaveChangesAsync();

                return Results.Ok(new { Success = true, Message = "Authenticated and session captured" });
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/schulware/accounts/{accountId:guid}/sync", async (
                Guid accountId,
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var account = await db.Accounts.FirstOrDefaultAsync(a => a.Id == accountId && a.ApplicationUserId == userId);
                if (account is null) return Results.NotFound();

                var syncState = await db.SyncStates.FirstOrDefaultAsync(s => s.AccountId == accountId);
                return Results.Ok(new
                {
                    account.Id, account.SchulnetzBaseUrl, account.DisplayName,
                    HasMobileToken = account.MobileAccessToken is not null,
                    HasWebSession = account.WebSessionId is not null,
                    LastSync = syncState?.LastSyncAt,
                    SyncStatus = syncState?.LastSyncStatus,
                    SyncError = syncState?.LastSyncError,
                });
            }).RequireAuthorization();
        }

        public async Task MigrateAsync(IServiceProvider serviceProvider, CancellationToken cancellationToken = default)
        {
            using var scope = serviceProvider.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<SchulwareDbContext>();
            await db.Database.EnsureCreatedAsync(cancellationToken);
        }

        internal static SchulwareApiClient CreateClient(IHttpClientFactory httpClientFactory, string baseUrl)
        {
            var httpClient = httpClientFactory.CreateClient("Schulware");
            var adapter = new HttpClientRequestAdapter(new AnonymousAuthenticationProvider(), httpClient: httpClient);
            adapter.BaseUrl = baseUrl;
            return new SchulwareApiClient(adapter);
        }
    }

    public record ConnectAccountRequest(
        string SchulnetzBaseUrl,
        string? SchulwareApiBaseUrl,
        string? DisplayName,
        Guid? SchoolUserId);

    public record OAuthCallbackRequest(string Code, string CodeVerifier, string? State);

    public record TokenResponse(
        [property: System.Text.Json.Serialization.JsonPropertyName("access_token")] string? AccessToken,
        [property: System.Text.Json.Serialization.JsonPropertyName("refresh_token")] string? RefreshToken);
}
