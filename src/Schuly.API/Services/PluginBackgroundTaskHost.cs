using Schuly.Plugin.Abstractions;

namespace Schuly.API.Services
{
    public class PluginBackgroundTaskHost(IServiceProvider serviceProvider, ILogger<PluginBackgroundTaskHost> logger) : BackgroundService
    {
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var tasks = serviceProvider.GetServices<IPluginBackgroundTask>();

            var runners = tasks.Select(task => RunTaskLoop(task, stoppingToken));
            await Task.WhenAll(runners);
        }

        private async Task RunTaskLoop(IPluginBackgroundTask task, CancellationToken stoppingToken)
        {
            logger.LogInformation("Plugin background task '{Name}' started with interval {Interval}", task.Name, task.Interval);

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await task.ExecuteAsync(serviceProvider, stoppingToken);
                }
                catch (Exception ex)
                {
                    logger.LogError(ex, "Plugin background task '{Name}' failed", task.Name);
                }

                try
                {
                    await Task.Delay(task.Interval, stoppingToken);
                }
                catch (OperationCanceledException)
                {
                    break;
                }
            }

            logger.LogInformation("Plugin background task '{Name}' stopped", task.Name);
        }
    }
}
