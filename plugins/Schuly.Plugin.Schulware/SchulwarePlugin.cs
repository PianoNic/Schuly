using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Kiota.Abstractions.Authentication;
using Microsoft.Kiota.Http.HttpClientLibrary;
using Schuly.Plugin.Abstractions;
using Schuly.Plugin.Schulware.Client;

namespace Schuly.Plugin.Schulware
{
    public class SchulwarePlugin : ISchulyPlugin
    {
        public string Name => "Schulware Integration";
        public string Version => "1.0.0";

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddScoped(sp =>
            {
                var httpClient = sp.GetRequiredService<IHttpClientFactory>().CreateClient("Schulware");
                var adapter = new HttpClientRequestAdapter(new AnonymousAuthenticationProvider(), httpClient: httpClient);
                adapter.BaseUrl = "http://localhost:8000";
                return new SchulwareApiClient(adapter);
            });
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
                return Results.Ok(new { Status = "Connected", Plugin = "Schulware Integration", Version = "1.0.0" });
            }).AllowAnonymous();
        }
    }
}
