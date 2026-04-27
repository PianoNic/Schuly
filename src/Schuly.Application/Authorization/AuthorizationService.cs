using Microsoft.AspNetCore.Http;
using Schuly.Domain.Enums;
using System.Security.Claims;

namespace Schuly.Application.Authorization
{
    public interface IAppAuthorizationService
    {
        Task CanAuthorizeAsync<T>(T obj) where T : notnull;
    }

    public class AuthorizationService(IHttpContextAccessor httpContextAccessor) : IAppAuthorizationService
    {
        public Task CanAuthorizeAsync<T>(T obj) where T : notnull
        {
            if (obj is not IHasAuthorization authRequest)
                return Task.CompletedTask;

            var requiredRole = authRequest.GetRequiredRole();
            var currentUserRole = GetCurrentUserRole();

            if (!IsRoleAuthorized(currentUserRole, requiredRole))
            {
                throw new UnauthorizedAccessException(
                    $"User with role {currentUserRole} is not authorized to perform this action. Required role: {requiredRole}.");
            }

            return Task.CompletedTask;
        }

        private Roles GetCurrentUserRole()
        {
            var roleClaim = httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.Role)?.Value;
            if (roleClaim != null && Enum.TryParse<Roles>(roleClaim, out var role))
                return role;

            return Roles.Student;
        }

        private static bool IsRoleAuthorized(Roles userRole, Roles requiredRole)
        {
            if (userRole == Roles.Administrator)
                return true;

            return userRole >= requiredRole;
        }
    }
}
