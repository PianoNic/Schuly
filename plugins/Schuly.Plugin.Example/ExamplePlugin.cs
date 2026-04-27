using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.DependencyInjection;
using Schuly.Plugin.Abstractions;

namespace Schuly.Plugin.Example
{
    public class ExamplePlugin : ISchulyPlugin
    {
        public string Name => "Example Plugin";
        public string Version => "1.0.0";

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddScoped<IPluginEventHandler<Schuly.Application.Commands.SchoolUser.CreateSchoolUserCommand>, OnSchoolUserCreatedHandler>();
        }

        public void ConfigureEndpoints(IEndpointRouteBuilder endpoints)
        {
            endpoints.MapGet("/api/plugins/example/hello", (IPluginUserContext userContext) =>
            {
                return Results.Ok(new { Message = "Hello from the Example Plugin!", Plugin = Name, Version });
            }).RequireAuthorization();

            endpoints.MapGet("/api/plugins/example/info", () =>
            {
                return Results.Ok(new { Name, Version, Description = "A sample plugin demonstrating the Schuly plugin system." });
            }).AllowAnonymous();
        }
    }
}
