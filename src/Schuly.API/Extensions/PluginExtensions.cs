using Schuly.Plugin.Abstractions;
using System.Reflection;

namespace Schuly.API.Extensions
{
    public static class PluginExtensions
    {
        public static IServiceCollection AddPlugins(this IServiceCollection services, IConfiguration configuration)
        {
            var plugins = DiscoverPlugins(configuration);

            foreach (var plugin in plugins)
            {
                plugin.ConfigureServices(services);
            }

            services.AddSingleton<IReadOnlyList<ISchulyPlugin>>(plugins);

            return services;
        }

        public static WebApplication UsePlugins(this WebApplication app)
        {
            var plugins = app.Services.GetRequiredService<IReadOnlyList<ISchulyPlugin>>();

            foreach (var plugin in plugins)
            {
                plugin.ConfigureEndpoints(app);
                app.Logger.LogInformation("Loaded plugin: {Name} v{Version}", plugin.Name, plugin.Version);
            }

            return app;
        }

        private static List<ISchulyPlugin> DiscoverPlugins(IConfiguration configuration)
        {
            var plugins = new List<ISchulyPlugin>();
            var pluginDir = configuration["Plugins:Directory"] ?? "plugins";

            if (!Path.IsPathRooted(pluginDir))
                pluginDir = Path.Combine(AppContext.BaseDirectory, pluginDir);

            if (!Directory.Exists(pluginDir))
                return plugins;

            foreach (var dll in Directory.GetFiles(pluginDir, "*.dll"))
            {
                try
                {
                    var assembly = Assembly.LoadFrom(dll);
                    var pluginTypes = assembly.GetTypes()
                        .Where(t => typeof(ISchulyPlugin).IsAssignableFrom(t) && t is { IsAbstract: false, IsInterface: false });

                    foreach (var type in pluginTypes)
                    {
                        if (Activator.CreateInstance(type) is ISchulyPlugin plugin)
                            plugins.Add(plugin);
                    }
                }
                catch
                {
                    // Skip DLLs that can't be loaded
                }
            }

            return plugins;
        }
    }
}
