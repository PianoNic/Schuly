using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
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
            var client = scope.ServiceProvider.GetRequiredService<SchulwareApiClient>();
            var logger = scope.ServiceProvider.GetRequiredService<ILogger<SchulwareSyncTask>>();
            var mainDb = scope.ServiceProvider.GetRequiredService<Schuly.Infrastructure.SchulyDbContext>();

            var credentials = await db.Credentials.ToListAsync(cancellationToken);

            foreach (var credential in credentials)
            {
                var syncState = await db.SyncStates
                    .FirstOrDefaultAsync(s => s.ApplicationUserId == credential.ApplicationUserId, cancellationToken);

                if (syncState == null)
                {
                    syncState = new SyncState { ApplicationUserId = credential.ApplicationUserId };
                    db.SyncStates.Add(syncState);
                }

                try
                {
                    // TODO: Set bearer token on client from credential.EncryptedToken
                    // TODO: Fetch grades, absences, exams from SchulwareAPI
                    // TODO: Map and upsert into main Schuly DB

                    syncState.LastSyncAt = DateTime.UtcNow;
                    syncState.LastSyncStatus = "Success";
                    syncState.LastSyncError = null;

                    logger.LogInformation("Synced data for user {UserId}", credential.ApplicationUserId);
                }
                catch (Exception ex)
                {
                    syncState.LastSyncAt = DateTime.UtcNow;
                    syncState.LastSyncStatus = "Failed";
                    syncState.LastSyncError = ex.Message;

                    logger.LogError(ex, "Failed to sync data for user {UserId}", credential.ApplicationUserId);
                }

                await db.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
