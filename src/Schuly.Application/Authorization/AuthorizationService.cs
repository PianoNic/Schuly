using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;

namespace Schuly.Application.Authorization
{
    public interface IAuthorizationService
    {
        Task CanAuthorizeAsync<T>(T obj) where T : notnull;
    }

    public class AuthorizationService(IUserService userService) : IAuthorizationService
    {
        public Task CanAuthorizeAsync<T>(T obj) where T : notnull
        {
            if (obj is not IHasAuthorization authRequest)
                return Task.CompletedTask;

            var requiredRole = authRequest.GetRequiredRole();
            var currentUserRole = userService.GetCurrentUserRole();

            if (!IsRoleAuthorized(currentUserRole, requiredRole))
            {
                throw new UnauthorizedAccessException(
                    $"User with role {currentUserRole} is not authorized to perform this action. Required role: {requiredRole}.");
            }

            return Task.CompletedTask;
        }

        private static bool IsRoleAuthorized(Roles userRole, Roles requiredRole)
        {
            if (userRole == Roles.Administrator)
                return true;

            return userRole >= requiredRole;
        }
    }
}
