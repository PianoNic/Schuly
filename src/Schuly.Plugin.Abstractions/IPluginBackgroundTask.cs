namespace Schuly.Plugin.Abstractions
{
    public interface IPluginBackgroundTask
    {
        string Name { get; }
        TimeSpan Interval { get; }
        Task ExecuteAsync(IServiceProvider serviceProvider, CancellationToken cancellationToken);
    }
}
