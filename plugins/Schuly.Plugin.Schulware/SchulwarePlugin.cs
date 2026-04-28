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
using System.Text.Json;

namespace Schuly.Plugin.Schulware
{
    public class SchulwarePlugin : ISchulyPlugin
    {
        public string Name => "Schulware Integration";
        public string Version => "1.0.0";

        public void ConfigureServices(IServiceCollection services, PluginServiceContext context)
        {
            services.AddDbContext<SchulwareDbContext>(options =>
                options.UseNpgsql(context.ConnectionString));

            var baseUrl = context.Configuration["SchulwareApi:BaseUrl"] ?? "https://schlwr.pianonic.ch";

            services.AddScoped(sp =>
            {
                var httpClient = sp.GetRequiredService<IHttpClientFactory>().CreateClient("Schulware");
                var adapter = new HttpClientRequestAdapter(new AnonymousAuthenticationProvider(), httpClient: httpClient);
                adapter.BaseUrl = baseUrl;
                return new SchulwareApiClient(adapter);
            });

            services.AddSingleton<IPluginBackgroundTask, SchulwareSyncTask>();
        }

        public void ConfigureEndpoints(IEndpointRouteBuilder endpoints)
        {
            endpoints.MapGet("/api/plugins/schulware/info", async (SchulwareApiClient client) =>
            {
                var info = await client.Api.App.AppInfo.GetAsync();
                return Results.Ok(info);
            }).AllowAnonymous();

            endpoints.MapGet("/api/plugins/schulware/status", () =>
            {
                return Results.Ok(new { Status = "Connected", Plugin = Name, Version });
            }).AllowAnonymous();

            endpoints.MapPost("/api/plugins/schulware/auth/unified", async (
                AuthenticateRequestDto request,
                IPluginUserContext userContext,
                SchulwareDbContext db,
                SchulwareApiClient client) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var result = await client.Api.Authenticate.Unified.PostAsync(request);

                if (result is null || result.Success != true)
                    return Results.BadRequest(result?.Message ?? "Unified authentication failed");

                await UpsertCredential(db, userId, credential =>
                {
                    credential.MobileAccessToken = result.AccessToken;
                    credential.MobileRefreshToken = result.RefreshToken;
                    credential.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);
                });

                return Results.Ok(new { Success = true, Message = "Schulware unified credentials stored" });
            }).RequireAuthorization();

            endpoints.MapPost("/api/plugins/schulware/auth/mobile", async (
                AuthenticateRequestDto request,
                IPluginUserContext userContext,
                SchulwareDbContext db,
                SchulwareApiClient client) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var body = new Body_authenticateMobile { Email = request.Email, Password = request.Password };
                var result = await client.Api.Authenticate.Mobile.PostAsync(body);

                if (result is null || result.Success != true)
                    return Results.BadRequest(result?.Message ?? "Mobile authentication failed");

                await UpsertCredential(db, userId, credential =>
                {
                    credential.MobileAccessToken = result.AccessToken;
                    credential.MobileRefreshToken = result.RefreshToken;
                    credential.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);
                });

                return Results.Ok(new { Success = true, Message = "Schulware mobile credentials stored" });
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/schulware/auth/oauth/url", async (SchulwareApiClient client) =>
            {
                var result = await client.Api.Authenticate.Oauth.Mobile.Url.GetAsync();
                return Results.Ok(result);
            }).RequireAuthorization();

            endpoints.MapPost("/api/plugins/schulware/auth/oauth/callback", async (
                MobileCallbackRequestDto request,
                IPluginUserContext userContext,
                SchulwareDbContext db,
                SchulwareApiClient client) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var result = await client.Api.Authenticate.Oauth.Mobile.Callback.PostAsync(request);

                if (result is null)
                    return Results.BadRequest("OAuth callback failed");

                await UpsertCredential(db, userId, credential =>
                {
                    credential.MobileAccessToken = result.AccessToken;
                    credential.MobileRefreshToken = result.RefreshToken;
                    credential.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);
                });

                return Results.Ok(new { Success = true, Message = "Schulware OAuth credentials stored" });
            }).RequireAuthorization();

            endpoints.MapDelete("/api/plugins/schulware/auth", async (
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var credential = await db.Credentials.FirstOrDefaultAsync(c => c.ApplicationUserId == userId);

                if (credential is not null)
                {
                    db.Credentials.Remove(credential);
                    await db.SaveChangesAsync();
                }

                return Results.NoContent();
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/schulware/auth/status", async (
                IPluginUserContext userContext,
                SchulwareDbContext db) =>
            {
                var userId = await userContext.GetCurrentUserIdAsync();
                var credential = await db.Credentials.FirstOrDefaultAsync(c => c.ApplicationUserId == userId);

                if (credential is null)
                    return Results.Ok(new { Connected = false });

                return Results.Ok(new
                {
                    Connected = true,
                    HasMobileToken = credential.MobileAccessToken is not null,
                    HasWebSession = credential.WebSessionId is not null,
                    MobileTokenExpires = credential.MobileTokenExpiresAt,
                    LastUpdated = credential.UpdatedAt
                });
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/schulware/sync-status", async (SchulwareDbContext db) =>
            {
                var states = await db.SyncStates.ToListAsync();
                return Results.Ok(states);
            }).RequireAuthorization();
        }

        public async Task MigrateAsync(IServiceProvider serviceProvider, CancellationToken cancellationToken = default)
        {
            using var scope = serviceProvider.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<SchulwareDbContext>();
            await db.Database.EnsureCreatedAsync(cancellationToken);
        }

        private static async Task UpsertCredential(SchulwareDbContext db, Guid userId, Action<SchulwareCredential> update)
        {
            var credential = await db.Credentials.FirstOrDefaultAsync(c => c.ApplicationUserId == userId);
            if (credential is null)
            {
                credential = new SchulwareCredential { ApplicationUserId = userId };
                db.Credentials.Add(credential);
            }

            update(credential);
            credential.UpdatedAt = DateTime.UtcNow;
            await db.SaveChangesAsync();
        }
    }
}
