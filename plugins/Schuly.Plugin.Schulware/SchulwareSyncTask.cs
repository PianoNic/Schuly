using System.Net.Http.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Kiota.Abstractions.Authentication;
using Microsoft.Kiota.Http.HttpClientLibrary;
using Schuly.Domain;
using Schuly.Domain.Enums;
using Schuly.Plugin.Abstractions;
using Schuly.Plugin.Schulware.Client;
using Schuly.Plugin.Schulware.Data;

namespace Schuly.Plugin.Schulware
{
    public class SchulwareSyncTask : IPluginBackgroundTask
    {
        public string Name => "Schulware Data Sync";
        public TimeSpan Interval => TimeSpan.FromMinutes(30);

        public async Task ExecuteAsync(IServiceProvider serviceProvider, CancellationToken cancellationToken)
        {
            using var scope = serviceProvider.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<SchulwareDbContext>();
            var mainDb = scope.ServiceProvider.GetRequiredService<Schuly.Infrastructure.SchulyDbContext>();
            var httpClientFactory = scope.ServiceProvider.GetRequiredService<IHttpClientFactory>();
            var logger = scope.ServiceProvider.GetRequiredService<ILogger<SchulwareSyncTask>>();

            var accounts = await db.Accounts
                .Where(a => a.MobileAccessToken != null && a.SchoolUserId != null)
                .ToListAsync(cancellationToken);

            logger.LogInformation("Syncing {Count} Schulware accounts", accounts.Count);

            foreach (var account in accounts)
            {
                var syncState = await db.SyncStates
                    .FirstOrDefaultAsync(s => s.AccountId == account.Id, cancellationToken);

                if (syncState is null)
                {
                    syncState = new SyncState { AccountId = account.Id };
                    db.SyncStates.Add(syncState);
                }

                try
                {
                    if (account.MobileTokenExpiresAt.HasValue && account.MobileTokenExpiresAt < DateTime.UtcNow)
                    {
                        if (account.MobileRefreshToken is not null)
                        {
                            var refreshed = await TryRefreshToken(httpClientFactory, account, db, logger, cancellationToken);
                            if (!refreshed)
                            {
                                syncState.LastSyncAt = DateTime.UtcNow;
                                syncState.LastSyncStatus = "TokenExpired";
                                syncState.LastSyncError = "Token expired and refresh failed. User needs to re-authenticate.";
                                continue;
                            }
                        }
                        else
                        {
                            syncState.LastSyncAt = DateTime.UtcNow;
                            syncState.LastSyncStatus = "TokenExpired";
                            syncState.LastSyncError = "Token expired. No refresh token available. User needs to re-authenticate.";
                            continue;
                        }
                    }

                    var client = CreateAuthenticatedClient(httpClientFactory, account);
                    await SyncGrades(client, account, mainDb, logger, cancellationToken);
                    await SyncAbsences(client, account, mainDb, logger, cancellationToken);

                    syncState.LastSyncAt = DateTime.UtcNow;
                    syncState.LastSyncStatus = "Success";
                    syncState.LastSyncError = null;

                    logger.LogInformation("Synced account {AccountId} ({Url})", account.Id, account.SchulnetzBaseUrl);
                }
                catch (Exception ex)
                {
                    syncState.LastSyncAt = DateTime.UtcNow;
                    syncState.LastSyncStatus = "Failed";
                    syncState.LastSyncError = ex.Message;

                    logger.LogError(ex, "Failed to sync account {AccountId}", account.Id);
                }

                await db.SaveChangesAsync(cancellationToken);
            }
        }

        private static async Task<bool> TryRefreshToken(
            IHttpClientFactory httpClientFactory, SchulwareAccount account,
            SchulwareDbContext db, ILogger logger, CancellationToken ct)
        {
            // Try direct token.php refresh first
            try
            {
                using var httpClient = httpClientFactory.CreateClient("Schulware");
                var tokenUrl = $"{account.SchulnetzBaseUrl}/token.php";

                var content = new FormUrlEncodedContent(new[]
                {
                    new KeyValuePair<string, string>("grant_type", "refresh_token"),
                    new KeyValuePair<string, string>("refresh_token", account.MobileRefreshToken!),
                    new KeyValuePair<string, string>("client_id", "ppyybShnMerHdtBQ"),
                });

                var response = await httpClient.PostAsync(tokenUrl, content, ct);
                if (response.IsSuccessStatusCode)
                {
                    var json = await response.Content.ReadFromJsonAsync<System.Text.Json.JsonElement>(ct);
                    var accessToken = json.GetProperty("access_token").GetString();
                    var refreshToken = json.TryGetProperty("refresh_token", out var rt) ? rt.GetString() : account.MobileRefreshToken;

                    account.MobileAccessToken = accessToken;
                    account.MobileRefreshToken = refreshToken;
                    account.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);
                    account.UpdatedAt = DateTime.UtcNow;
                    await db.SaveChangesAsync(ct);

                    logger.LogInformation("Refreshed token via token.php for account {AccountId}", account.Id);
                    return true;
                }

                logger.LogWarning("Direct token refresh failed ({Status}), trying Playwright refresher", response.StatusCode);
            }
            catch (Exception ex)
            {
                logger.LogWarning(ex, "Direct token refresh error, trying Playwright refresher");
            }

            // Fall back to Playwright refresher service
            return await TryPlaywrightRefresh(httpClientFactory, account, db, logger, ct);
        }

        private static async Task<bool> TryPlaywrightRefresh(
            IHttpClientFactory httpClientFactory, SchulwareAccount account,
            SchulwareDbContext db, ILogger logger, CancellationToken ct)
        {
            try
            {
                var refresherUrl = Environment.GetEnvironmentVariable("SCHULWARE_REFRESHER_URL") ?? "http://localhost:8001";

                using var httpClient = httpClientFactory.CreateClient();
                var response = await httpClient.PostAsJsonAsync($"{refresherUrl}/refresh", new
                {
                    schulnetz_base_url = account.SchulnetzBaseUrl,
                    user_id = account.Id.ToString(),
                }, ct);

                if (!response.IsSuccessStatusCode)
                {
                    logger.LogWarning("Playwright refresher returned {Status}", response.StatusCode);
                    return false;
                }

                var result = await response.Content.ReadFromJsonAsync<System.Text.Json.JsonElement>(ct);
                if (!result.TryGetProperty("success", out var success) || !success.GetBoolean())
                {
                    var msg = result.TryGetProperty("message", out var m) ? m.GetString() : "unknown error";
                    logger.LogWarning("Playwright refresher failed: {Message}", msg);
                    return false;
                }

                if (result.TryGetProperty("access_token", out var at) && at.ValueKind == System.Text.Json.JsonValueKind.String)
                    account.MobileAccessToken = at.GetString();

                if (result.TryGetProperty("refresh_token", out var rtk) && rtk.ValueKind == System.Text.Json.JsonValueKind.String)
                    account.MobileRefreshToken = rtk.GetString();

                account.MobileTokenExpiresAt = DateTime.UtcNow.AddHours(1);

                if (result.TryGetProperty("session_id", out var sid) && sid.ValueKind == System.Text.Json.JsonValueKind.String)
                    account.WebSessionId = sid.GetString();

                if (result.TryGetProperty("web_session_user_id", out var wuid) && wuid.ValueKind == System.Text.Json.JsonValueKind.String)
                    account.WebSessionUserId = wuid.GetString();

                if (result.TryGetProperty("web_session_trans_id", out var wtid) && wtid.ValueKind == System.Text.Json.JsonValueKind.String)
                    account.WebSessionTransId = wtid.GetString();

                account.UpdatedAt = DateTime.UtcNow;
                try
                {
                    db.Accounts.Update(account);
                    await db.SaveChangesAsync(ct);
                    logger.LogInformation("Refreshed tokens via Playwright for account {AccountId}. Expires: {Expires}", account.Id, account.MobileTokenExpiresAt);
                }
                catch (Exception saveEx)
                {
                    logger.LogError(saveEx, "Failed to save refreshed tokens for account {AccountId}", account.Id);
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Playwright refresh error for account {AccountId}", account.Id);
                return false;
            }
        }

        private static SchulwareApiClient CreateAuthenticatedClient(IHttpClientFactory httpClientFactory, SchulwareAccount account)
        {
            var httpClient = httpClientFactory.CreateClient("Schulware");
            httpClient.DefaultRequestHeaders.Authorization =
                new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", account.MobileAccessToken);

            var adapter = new HttpClientRequestAdapter(new AnonymousAuthenticationProvider(), httpClient: httpClient);
            adapter.BaseUrl = account.SchulwareApiBaseUrl;
            return new SchulwareApiClient(adapter);
        }

        private static async Task SyncGrades(
            SchulwareApiClient client, SchulwareAccount account,
            Schuly.Infrastructure.SchulyDbContext mainDb, ILogger logger, CancellationToken ct)
        {
            var grades = await client.Api.Mobile.Grades.GetAsync(cancellationToken: ct);
            if (grades is null || grades.Count == 0) return;

            var schoolUserId = account.SchoolUserId!.Value;
            var synced = 0;

            foreach (var grade in grades)
            {
                if (grade.Mark is null || grade.ExamId is null) continue;

                var exam = await FindOrCreateExam(mainDb, grade, schoolUserId, ct);

                var existing = await mainDb.Grades
                    .FirstOrDefaultAsync(g => g.SchoolUserId == schoolUserId && g.ExamId == exam.Id, ct);

                if (existing is null)
                {
                    mainDb.Grades.Add(new Grade
                    {
                        SchoolUserId = schoolUserId,
                        ExamId = exam.Id,
                        Score = (decimal)grade.Mark,
                        Weighting = (decimal)(grade.Weight ?? 1),
                    });
                    synced++;
                }
                else if (existing.Score != (decimal)grade.Mark)
                {
                    existing.Score = (decimal)grade.Mark;
                    existing.Weighting = (decimal)(grade.Weight ?? 1);
                    synced++;
                }
            }

            if (synced > 0)
            {
                await mainDb.SaveChangesAsync(ct);
                logger.LogInformation("Synced {Count} grades for account {AccountId}", synced, account.Id);
            }
        }

        private static async Task<Exam> FindOrCreateExam(
            Schuly.Infrastructure.SchulyDbContext mainDb,
            Client.Models.GradeDto grade, Guid schoolUserId, CancellationToken ct)
        {
            var examName = grade.Title ?? grade.Subject ?? $"Exam {grade.ExamId}";

            var schoolUser = await mainDb.SchoolUsers
                .Include(su => su.Classes)
                .FirstOrDefaultAsync(su => su.Id == schoolUserId, ct);

            var cls = schoolUser?.Classes.FirstOrDefault();
            if (cls is null && schoolUser is not null)
            {
                var className = grade.Course ?? grade.Subject ?? "Default";
                cls = await mainDb.Classes.FirstOrDefaultAsync(c => c.Name == className && c.SchoolId == schoolUser.SchoolId, ct);
                if (cls is null)
                {
                    cls = new Schuly.Domain.Class
                    {
                        Name = className,
                        SchoolId = schoolUser.SchoolId,
                    };
                    mainDb.Classes.Add(cls);
                    await mainDb.SaveChangesAsync(ct);
                }
            }

            var classId = cls?.Id ?? Guid.Empty;
            if (classId == Guid.Empty) return new Exam { Id = Guid.NewGuid(), Name = examName, Type = ExamType.Classic, ClassId = classId };

            var existing = await mainDb.Exams
                .FirstOrDefaultAsync(e => e.Name == examName && e.ClassId == classId, ct);

            if (existing is not null) return existing;

            var exam = new Exam
            {
                Name = examName,
                Type = ExamType.Classic,
                ClassId = classId,
            };
            mainDb.Exams.Add(exam);
            await mainDb.SaveChangesAsync(ct);
            return exam;
        }

        private static async Task SyncAbsences(
            SchulwareApiClient client, SchulwareAccount account,
            Schuly.Infrastructure.SchulyDbContext mainDb, ILogger logger, CancellationToken ct)
        {
            var absences = await client.Api.Mobile.Absences.GetAsync(cancellationToken: ct);
            if (absences is null || absences.Count == 0) return;

            var schoolUserId = account.SchoolUserId!.Value;
            var synced = 0;

            foreach (var absence in absences)
            {
                if (absence.DateFrom is null || absence.DateTo is null) continue;

                if (!DateTime.TryParse(absence.DateFrom, out var from) ||
                    !DateTime.TryParse(absence.DateTo, out var to))
                    continue;

                from = DateTime.SpecifyKind(from, DateTimeKind.Utc);
                to = DateTime.SpecifyKind(to, DateTimeKind.Utc);

                var existing = await mainDb.Absences
                    .FirstOrDefaultAsync(a => a.SchoolUserId == schoolUserId
                        && a.From == from && a.Until == to, ct);

                if (existing is null)
                {
                    mainDb.Absences.Add(new Absence
                    {
                        SchoolUserId = schoolUserId,
                        From = from,
                        Until = to,
                        Reason = absence.Reason ?? "Imported from Schulnetz",
                        Type = AbsenceType.Absence,
                    });
                    synced++;
                }
            }

            if (synced > 0)
            {
                await mainDb.SaveChangesAsync(ct);
                logger.LogInformation("Synced {Count} absences for account {AccountId}", synced, account.Id);
            }
        }
    }
}
