using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Kiota.Abstractions.Authentication;
using Microsoft.Kiota.Http.HttpClientLibrary;
using Schuly.Plugin.Abstractions;
using Schuly.Plugin.Schulware.Client;
using Schuly.Plugin.Schulware.Data;

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

            var baseUrl = context.Configuration["SchulwareApi:BaseUrl"] ?? "http://localhost:8000";

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
    }
}
