using Microsoft.EntityFrameworkCore;

namespace Schuly.Plugin.Schulware.Data
{
    public class SchulwareDbContext(DbContextOptions<SchulwareDbContext> options) : DbContext(options)
    {
        public DbSet<SchulwareCredential> Credentials { get; set; }
        public DbSet<SyncState> SyncStates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SchulwareCredential>(entity =>
            {
                entity.HasKey(c => c.Id);
                entity.HasIndex(c => c.ApplicationUserId).IsUnique();
            });

            modelBuilder.Entity<SyncState>(entity =>
            {
                entity.HasKey(s => s.Id);
                entity.HasIndex(s => s.ApplicationUserId).IsUnique();
            });
        }
    }

    public class SchulwareCredential
    {
        public Guid Id { get; set; }
        public Guid ApplicationUserId { get; set; }
        public string? MobileAccessToken { get; set; }
        public string? MobileRefreshToken { get; set; }
        public DateTime? MobileTokenExpiresAt { get; set; }
        public string? WebSessionId { get; set; }
        public string? WebNavigationUrlsJson { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; }
    }

    public class SyncState
    {
        public Guid Id { get; set; }
        public Guid ApplicationUserId { get; set; }
        public DateTime? LastSyncAt { get; set; }
        public string? LastSyncStatus { get; set; }
        public string? LastSyncError { get; set; }
    }
}
