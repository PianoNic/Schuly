using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.API.Extensions
{
    public static class MigrationExtensions
    {
        public static WebApplication ApplyMigrations(this WebApplication app)
        {
            using var scope = app.Services.CreateScope();
            var db = scope.ServiceProvider.GetRequiredService<SchulyDbContext>();
            db.Database.Migrate();
            return app;
        }
    }
}
