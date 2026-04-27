namespace Schuly.Plugin.Abstractions
{
    public interface IPluginUserContext
    {
        Task<Guid> GetCurrentUserIdAsync(CancellationToken cancellationToken = default);
        Task<Guid?> GetCurrentSchoolUserIdAsync(CancellationToken cancellationToken = default);
    }
}
