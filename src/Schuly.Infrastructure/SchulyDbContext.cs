using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Schuly.Domain;

namespace Schuly.Infrastructure
{
    public class SchulyDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Grade> Grades { get; set; }
        public DbSet<Exam> Exams { get; set; }
        public DbSet<Class> Classes { get; set; }
        public DbSet<Absence> Absences { get; set; }
        public DbSet<ExamAverage> ExamAverages { get; set; }
        public DbSet<AgendaEntry> AgendaEntries { get; set; }
        public DbSet<UserClass> UserClasses { get; set; }

        public SchulyDbContext(DbContextOptions<SchulyDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(u => u.Id);
                entity.HasIndex(u => u.Email).IsUnique();
                entity.Property(u => u.Email).HasMaxLength(255);
                entity.Property(u => u.FirstName).HasMaxLength(100);
                entity.Property(u => u.LastName).HasMaxLength(100);
                entity.Property(u => u.Role).IsRequired();
            });

            modelBuilder.Entity<Grade>(entity =>
            {
                entity.HasKey(g => g.Id);
                entity.HasOne(g => g.User)
                    .WithMany(u => u.Grades)
                    .HasForeignKey(g => g.UserId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(g => g.Exam)
                    .WithMany(e => e.Grades)
                    .HasForeignKey(g => g.ExamId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(g => new { g.UserId, g.ExamId });
            });

            modelBuilder.Entity<Exam>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Name).HasMaxLength(200);

                entity.HasOne(e => e.Class)
                    .WithMany(c => c.Exams)
                    .HasForeignKey(e => e.ClassId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Class>(entity =>
            {
                entity.HasKey(c => c.Id);
                entity.Property(c => c.Name).HasMaxLength(100);
                entity.HasIndex(c => c.Name).IsUnique();
            });

            modelBuilder.Entity<AgendaEntry>(entity =>
            {
                entity.HasKey(ae => ae.Id);
                entity.Property(ae => ae.Title).HasMaxLength(200);
                entity.HasIndex(ae => ae.Date);

                entity.HasOne(ae => ae.Class)
                    .WithMany(c => c.AgendaEntries)
                    .HasForeignKey(ae => ae.ClassId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Absence>(entity =>
            {
                entity.HasKey(a => a.Id);

                entity.HasOne(a => a.User)
                    .WithMany(u => u.Absences)
                    .HasForeignKey(a => a.UserId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(a => new { a.UserId, a.From, a.Until });
            });

            modelBuilder.Entity<ExamAverage>(entity =>
            {
                entity.HasKey(ea => ea.Id);

                entity.HasOne(ea => ea.Exam)
                    .WithOne(e => e.ExamAverage)
                    .HasForeignKey<ExamAverage>(ea => ea.ExamId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(ea => ea.ExamId).IsUnique();
            });

            modelBuilder.Entity<UserClass>(entity =>
            {
                entity.HasKey(uc => new { uc.UserId, uc.ClassId });

                entity.HasOne(uc => uc.User)
                    .WithMany(u => u.UserClasses)
                    .HasForeignKey(uc => uc.UserId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(uc => uc.Class)
                    .WithMany(c => c.UserClasses)
                    .HasForeignKey(uc => uc.ClassId)
                    .OnDelete(DeleteBehavior.Cascade);
            });
        }

        public override int SaveChanges()
        {
            UpdateDateTrackingFields();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            UpdateDateTrackingFields();
            return base.SaveChangesAsync(cancellationToken);
        }

        private void UpdateDateTrackingFields()
        {
            var entries = ChangeTracker.Entries<Base>().Where(e => e.State == EntityState.Added || e.State == EntityState.Modified);

            foreach (var entry in entries)
            {
                if (entry.State == EntityState.Added)
                    entry.Entity.CreatedAt = DateTime.UtcNow;

                if (entry.State == EntityState.Modified)
                    entry.Entity.UpdatedAt = DateTime.UtcNow;
            }
        }
    }

    public class SchulyDbContextFactory : IDesignTimeDbContextFactory<SchulyDbContext>
    {
        public SchulyDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<SchulyDbContext>();
            optionsBuilder.UseNpgsql();
            return new SchulyDbContext(optionsBuilder.Options);
        }
    }
}
