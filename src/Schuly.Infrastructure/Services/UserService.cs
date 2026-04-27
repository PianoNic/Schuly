using Microsoft.EntityFrameworkCore;
using Schuly.Domain;
using Schuly.Domain.Enums;

namespace Schuly.Infrastructure.Services
{
    public class UserService(IOidcService oidcService, SchulyDbContext dbContext) : IUserService
    {
        public async Task<bool> ExistsAsync(string externalId, CancellationToken cancellationToken = default)
        {
            return await dbContext.ApplicationUsers.AnyAsync(u => u.ExternalId == externalId, cancellationToken);
        }

        public async Task<Guid> GetCurrentUserIdAsync(CancellationToken cancellationToken = default)
        {
            var oidcUser = await oidcService.GetCurrentUserAsync(cancellationToken)
                ?? throw new UnauthorizedAccessException("No authenticated user");

            var user = await dbContext.ApplicationUsers
                .SingleOrDefaultAsync(u => u.ExternalId == oidcUser.ExternalId, cancellationToken)
                ?? throw new UnauthorizedAccessException("User not found");

            return user.Id;
        }

        public async Task SyncCurrentUserAsync(CancellationToken cancellationToken = default)
        {
            var oidcUser = await oidcService.GetCurrentUserAsync(cancellationToken)
                ?? throw new UnauthorizedAccessException("No authenticated user");

            var user = await dbContext.ApplicationUsers
                .SingleOrDefaultAsync(u => u.ExternalId == oidcUser.ExternalId, cancellationToken);

            var email = oidcUser.Email ?? string.Empty;
            var displayName = oidcUser.DisplayName ?? "Schuly User";

            if (user is null)
            {
                user = new ApplicationUser
                {
                    Id = Guid.NewGuid(),
                    ExternalId = oidcUser.ExternalId,
                    AuthenticationEmail = email,
                    DisplayName = displayName,
                    ProfilePictureUrl = oidcUser.AvatarUrl,
                    IsEmailVerified = true,
                    IsTwoFactorEnabled = false
                };

                dbContext.ApplicationUsers.Add(user);
                await dbContext.SaveChangesAsync(cancellationToken);
                return;
            }

            user.AuthenticationEmail = email;
            user.DisplayName = displayName;
            user.ProfilePictureUrl = oidcUser.AvatarUrl;

            await dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
