using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public record UpdateApplicationUserCommand(Guid ApplicationUserId, string? DisplayName, string? ProfilePictureUrl) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class UpdateApplicationUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateApplicationUserCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateApplicationUserCommand command, CancellationToken cancellationToken)
        {
            var applicationUser = await dbContext.ApplicationUsers
                .FirstOrDefaultAsync(au => au.Id == command.ApplicationUserId, cancellationToken);

            if (applicationUser == null)
                return Result.Failure($"ApplicationUser with ID '{command.ApplicationUserId}' not found");

            if (!string.IsNullOrEmpty(command.DisplayName))
                applicationUser.DisplayName = command.DisplayName;

            if (!string.IsNullOrEmpty(command.ProfilePictureUrl))
                applicationUser.ProfilePictureUrl = command.ProfilePictureUrl;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
