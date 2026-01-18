using Schuly.Domain;

namespace Schuly.Application.Services.Interfaces
{
    public interface IUserService
    {
        Task<User?> GetCurrentUserAsync(CancellationToken cancellationToken = default);
        Guid GetCurrentUserId();
        string? GetCurrentUserEmail();
        Schuly.Domain.Enums.Roles GetCurrentUserRole();
        long GetCurrentSchoolId();
        Task<SchoolUser?> GetCurrentSchoolUserAsync(CancellationToken cancellationToken = default);
        Task<List<School>> GetSchoolsForCurrentUserAsync(CancellationToken cancellationToken = default);
    }
}
