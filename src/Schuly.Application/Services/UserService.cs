using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain;
using Schuly.Infrastructure;
using System.Security.Claims;

namespace Schuly.Application.Services
{
    public class UserService(IHttpContextAccessor httpContextAccessor, SchulyDbContext dbContext) : IUserService
    {
        public async Task<User?> GetCurrentUserAsync(CancellationToken cancellationToken = default)
        {
            var userId = GetCurrentUserId();
            if (userId == Guid.Empty)
                return null;

            return await dbContext.Users.FindAsync([userId], cancellationToken: cancellationToken);
        }

        public Guid GetCurrentUserId()
        {
            var userIdClaim = httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim?.Value != null && Guid.TryParse(userIdClaim.Value, out var userId))
                return userId;

            return Guid.Empty;
        }

        public string? GetCurrentUserEmail()
        {
            return httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.Email)?.Value;
        }

        public Domain.Enums.Roles GetCurrentUserRole()
        {
            var roleClaim = httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.Role)?.Value;
            if (roleClaim != null && Enum.TryParse<Domain.Enums.Roles>(roleClaim, out var role))
                return role;

            return Domain.Enums.Roles.Student;
        }

        public long GetCurrentSchoolId()
        {
            var schoolIdClaim = httpContextAccessor.HttpContext?.User?.FindFirst("SchoolId")?.Value;
            if (schoolIdClaim != null && long.TryParse(schoolIdClaim, out var schoolId))
                return schoolId;

            return 0;
        }

        public async Task<SchoolUser?> GetCurrentSchoolUserAsync(CancellationToken cancellationToken = default)
        {
            var userId = GetCurrentUserId();
            var schoolId = GetCurrentSchoolId();

            if (userId == Guid.Empty || schoolId == 0)
                return null;

            return await dbContext.SchoolUsers
                .FirstOrDefaultAsync(su => su.ApplicationUserId == userId && su.SchoolId == schoolId, cancellationToken);
        }

        public async Task<List<School>> GetSchoolsForCurrentUserAsync(CancellationToken cancellationToken = default)
        {
            var userId = GetCurrentUserId();
            if (userId == Guid.Empty)
                return [];

            return await dbContext.SchoolUsers
                .Where(su => su.ApplicationUserId == userId)
                .Include(su => su.School)
                .Select(su => su.School!)
                .Distinct()
                .ToListAsync(cancellationToken);
        }
    }
}
