using Schuly.Infrastructure.Services;
using Schuly.Plugin.Abstractions;

namespace Schuly.API.Services
{
    public class PluginUserContext(IUserService userService) : IPluginUserContext
    {
        public async Task<Guid> GetCurrentUserIdAsync(CancellationToken cancellationToken = default)
        {
            return await userService.GetCurrentUserIdAsync(cancellationToken);
        }

        public Task<Guid?> GetCurrentSchoolUserIdAsync(CancellationToken cancellationToken = default)
        {
            // TODO: implement when school context selection is added
            return Task.FromResult<Guid?>(null);
        }
    }
}
