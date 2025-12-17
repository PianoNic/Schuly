using Microsoft.AspNetCore.Http;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain;
using Schuly.Infrastructure;
using System.Security.Claims;

namespace Schuly.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly SchulyDbContext _dbContext;

        public UserService(IHttpContextAccessor httpContextAccessor, SchulyDbContext dbContext)
        {
            _httpContextAccessor = httpContextAccessor;
            _dbContext = dbContext;
        }

        public async Task<User?> GetCurrentUserAsync(CancellationToken cancellationToken = default)
        {
            var userId = GetCurrentUserId();
            if (userId == Guid.Empty)
                return null;

            return await _dbContext.Users.FindAsync([userId], cancellationToken: cancellationToken);
        }

        public Guid GetCurrentUserId()
        {
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim?.Value != null && Guid.TryParse(userIdClaim.Value, out var userId))
            {
                return userId;
            }

            return Guid.Empty;
        }

        public string? GetCurrentUserEmail()
        {
            return _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.Email)?.Value;
        }

        public Schuly.Domain.Enums.Roles GetCurrentUserRole()
        {
            var roleClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.Role)?.Value;
            if (roleClaim != null && Enum.TryParse<Schuly.Domain.Enums.Roles>(roleClaim, out var role))
            {
                return role;
            }

            return Domain.Enums.Roles.Student;
        }
    }
}
