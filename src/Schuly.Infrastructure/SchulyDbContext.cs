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
        public DbSet<Agenda> Agendas { get; set; }
        public DbSet<Absence> Absences { get; set; }

        public SchulyDbContext(DbContextOptions<SchulyDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
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
