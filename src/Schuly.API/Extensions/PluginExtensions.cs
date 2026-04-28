using Schuly.Plugin.Abstractions;
using System.Reflection;

namespace Schuly.API.Extensions
{
    public static class PluginExtensions
    {
        public static IServiceCollection AddPlugins(this IServiceCollection services, IConfiguration configuration)
        {
            var plugins = DiscoverPlugins(configuration);
            var mainConnectionString = configuration.GetConnectionString("SchulyDatabase")
                ?? throw new InvalidOperationException("SchulyDatabase connection string not configured");

            foreach (var plugin in plugins)
            {
                var pluginDbName = $"schuly_plugin_{plugin.Name.ToLowerInvariant().Replace(" ", "_")}";
                var pluginConnectionString = ReplaceDatabase(mainConnectionString, pluginDbName);
                var pluginConfig = LoadPluginConfig(plugin);
                var context = new PluginServiceContext(pluginConnectionString, pluginConfig);

                plugin.ConfigureServices(services, context);
            }

            services.AddSingleton<IReadOnlyList<ISchulyPlugin>>(plugins);

            return services;
        }

        public static async Task<WebApplication> UsePluginsAsync(this WebApplication app)
        {
            var plugins = app.Services.GetRequiredService<IReadOnlyList<ISchulyPlugin>>();

            foreach (var plugin in plugins)
            {
                await plugin.MigrateAsync(app.Services);
                plugin.ConfigureEndpoints(app);
                app.Logger.LogInformation("Loaded plugin: {Name} v{Version}", plugin.Name, plugin.Version);
            }

            return app;
        }

        private static IConfiguration LoadPluginConfig(ISchulyPlugin plugin)
        {
            var assemblyLocation = plugin.GetType().Assembly.Location;
            var pluginDir = Path.GetDirectoryName(assemblyLocation) ?? AppContext.BaseDirectory;
            var configPath = Path.Combine(pluginDir, "config.json");

            var builder = new ConfigurationBuilder();

            if (File.Exists(configPath))
                builder.AddJsonFile(configPath, optional: true, reloadOnChange: true);

            builder.AddEnvironmentVariables($"SCHULY_PLUGIN_{plugin.Name.ToUpperInvariant().Replace(" ", "_")}_");

            return builder.Build();
        }

        private static string ReplaceDatabase(string connectionString, string newDatabase)
        {
            var builder = new Npgsql.NpgsqlConnectionStringBuilder(connectionString)
            {
                Database = newDatabase
            };
            return builder.ConnectionString;
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
