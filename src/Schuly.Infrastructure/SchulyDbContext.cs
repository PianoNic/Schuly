using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Schuly.Domain;

namespace Schuly.Infrastructure
{
    public class SchulyDbContext : DbContext
    {
        public DbSet<Class> Classes { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<SchoolUser> SchoolUsers { get; set; }
        public DbSet<School> Schools { get; set; }
        public DbSet<Grade> Grades { get; set; }
        public DbSet<Exam> Exams { get; set; }
        public DbSet<Absence> Absences { get; set; }
        public DbSet<AgendaEntry> AgendaEntries { get; set; }

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

                entity.HasMany(u => u.Classes)
                      .WithMany(c => c.Students);

                entity.HasOne(u => u.School)
                    .WithMany(s => s.Users)
                    .HasForeignKey(u => u.SchoolId)
                    .OnDelete(DeleteBehavior.SetNull);

                entity.HasIndex(u => u.SchoolId);
            });

            modelBuilder.Entity<ApplicationUser>(entity =>
            {
                entity.HasKey(au => au.Id);
                entity.HasIndex(au => au.AuthenticationEmail).IsUnique();
                entity.Property(au => au.AuthenticationEmail).HasMaxLength(255);
                entity.Property(au => au.DisplayName).HasMaxLength(200);

                entity.HasMany(au => au.SchoolUsers)
                    .WithOne(su => su.ApplicationUser)
                    .HasForeignKey(su => su.ApplicationUserId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<School>(entity =>
            {
                entity.HasKey(s => s.Id);
                entity.Property(s => s.Name).HasMaxLength(200).IsRequired();
                entity.Property(s => s.Email).HasMaxLength(255);
                entity.Property(s => s.PhoneNumber).HasMaxLength(50);
                entity.Property(s => s.Website).HasMaxLength(255);
                entity.HasIndex(s => s.Name);

                entity.HasMany(s => s.SchoolUsers)
                    .WithOne(su => su.School)
                    .HasForeignKey(su => su.SchoolId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasMany(s => s.Classes)
                    .WithOne(c => c.School)
                    .HasForeignKey(c => c.SchoolId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasMany(s => s.Users)
                    .WithOne(u => u.School)
                    .HasForeignKey(u => u.SchoolId)
                    .OnDelete(DeleteBehavior.SetNull);
            });

            modelBuilder.Entity<SchoolUser>(entity =>
            {
                entity.HasKey(su => su.Id);
                entity.HasIndex(su => su.Email).IsUnique();
                entity.Property(su => su.Email).HasMaxLength(255);
                entity.Property(su => su.FirstName).HasMaxLength(100);
                entity.Property(su => su.LastName).HasMaxLength(100);
                entity.Property(su => su.Role).IsRequired();
                entity.Property(su => su.StudentNumber).HasMaxLength(50);
                entity.Property(su => su.TeacherCode).HasMaxLength(50);

                entity.HasOne(su => su.ApplicationUser)
                    .WithMany(au => au.SchoolUsers)
                    .HasForeignKey(su => su.ApplicationUserId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(su => su.School)
                    .WithMany(s => s.SchoolUsers)
                    .HasForeignKey(su => su.SchoolId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasIndex(su => su.SchoolId);
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

                entity.HasMany(c => c.Students)
                      .WithMany(u => u.Classes);

                entity.HasOne(c => c.School)
                    .WithMany(s => s.Classes)
                    .HasForeignKey(c => c.SchoolId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasIndex(c => c.SchoolId);
            });

            modelBuilder.Entity<AgendaEntry>(entity =>
            {
                entity.HasKey(ae => ae.Id);
                entity.Property(ae => ae.Title).HasMaxLength(200);
                entity.HasIndex(ae => ae.Date);

                entity.HasOne(ae => ae.Class)
                    .WithMany(c => c.Agenda)
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

                entity.HasIndex(a => new { a.UserId, a.From, a.Until, a.Type });
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
                {
                    entry.Entity.CreatedAt = DateTime.UtcNow;
                    entry.Entity.UpdatedAt = DateTime.UtcNow;
                }

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
