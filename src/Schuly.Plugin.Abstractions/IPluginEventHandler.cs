namespace Schuly.Plugin.Abstractions
{
    public interface IPluginEventHandler<in TCommand>
    {
        Task HandleAsync(TCommand command, CancellationToken cancellationToken = default);
    }
}
