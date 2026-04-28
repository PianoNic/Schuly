using Microsoft.EntityFrameworkCore;

namespace Schuly.Plugin.Schulware.Data
{
    public class SchulwareDbContext(DbContextOptions<SchulwareDbContext> options) : DbContext(options)
    {
        public DbSet<SchulwareAccount> Accounts { get; set; }
        public DbSet<SyncState> SyncStates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SchulwareAccount>(entity =>
            {
                entity.HasKey(a => a.Id);
                entity.HasIndex(a => new { a.ApplicationUserId, a.SchulnetzBaseUrl }).IsUnique();
            });

            modelBuilder.Entity<SyncState>(entity =>
            {
                entity.HasKey(s => s.Id);
                entity.HasIndex(s => s.AccountId).IsUnique();
                entity.HasOne(s => s.Account).WithOne().HasForeignKey<SyncState>(s => s.AccountId);
            });
        }
    }

    public class SchulwareAccount
    {
        public Guid Id { get; set; }
        public Guid ApplicationUserId { get; set; }
        public Guid? SchoolUserId { get; set; }

        public required string SchulnetzBaseUrl { get; set; }
        public required string SchulwareApiBaseUrl { get; set; }
        public string? SchulnetzStudentId { get; set; }
        public string? DisplayName { get; set; }

        public string? MobileAccessToken { get; set; }
        public string? MobileRefreshToken { get; set; }
        public DateTime? MobileTokenExpiresAt { get; set; }

        public string? WebSessionId { get; set; }
        public string? WebSessionUserId { get; set; }
        public string? WebSessionTransId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; }
    }

    public class SyncState
    {
        public Guid Id { get; set; }
        public Guid AccountId { get; set; }
        public SchulwareAccount? Account { get; set; }
        public DateTime? LastSyncAt { get; set; }
        public string? LastSyncStatus { get; set; }
        public string? LastSyncError { get; set; }
    }
}
