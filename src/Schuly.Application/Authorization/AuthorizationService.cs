using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;

namespace Schuly.Application.Authorization
{
    public class AuthorizationService
    {
        private readonly IUserService _userService;

        public AuthorizationService(IUserService userService)
        {
            _userService = userService;
        }

        public async Task CanAuthorizeAsync<T>(T obj) where T : notnull
        {
            if (obj is not IHasAuthorization authRequest)
                return;

            var requiredRole = authRequest.GetRequiredRole();
            var currentUserRole = _userService.GetCurrentUserRole();

            if (!IsRoleAuthorized(currentUserRole, requiredRole))
            {
                throw new UnauthorizedAccessException(
                    $"User with role {currentUserRole} is not authorized to perform this action. Required role: {requiredRole}.");
            }
        }

        private bool IsRoleAuthorized(Roles userRole, Roles requiredRole)
        {
            if (userRole == Roles.Administrator)
                return true;

            return userRole >= requiredRole;
        }
    }
}
