using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Schuly.Plugin.Abstractions
{
    public interface ISchulyPlugin
    {
        string Name { get; }
        string Version { get; }
        void ConfigureServices(IServiceCollection services, PluginServiceContext context);
        void ConfigureEndpoints(IEndpointRouteBuilder endpoints);
        Task MigrateAsync(IServiceProvider serviceProvider, CancellationToken cancellationToken = default);
    }

    public record PluginServiceContext(string ConnectionString, IConfiguration Configuration);
}
