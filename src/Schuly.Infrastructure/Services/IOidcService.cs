using Schuly.Infrastructure.Dtos;

namespace Schuly.Infrastructure.Services
{
    public interface IOidcService
    {
        Task<OidcUser?> GetCurrentUserAsync(CancellationToken cancellationToken = default);
    }
}
