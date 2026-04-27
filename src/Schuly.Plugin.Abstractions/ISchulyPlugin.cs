using Microsoft.AspNetCore.Routing;
using Microsoft.Extensions.DependencyInjection;

namespace Schuly.Plugin.Abstractions
{
    public interface ISchulyPlugin
    {
        string Name { get; }
        string Version { get; }
        void ConfigureServices(IServiceCollection services);
        void ConfigureEndpoints(IEndpointRouteBuilder endpoints);
    }
}
