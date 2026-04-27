using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public record DeleteApplicationUserCommand(Guid ApplicationUserId) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class DeleteApplicationUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteApplicationUserCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteApplicationUserCommand command, CancellationToken cancellationToken)
        {
            var applicationUser = await dbContext.ApplicationUsers
                .Include(au => au.SchoolUsers)
                .FirstOrDefaultAsync(au => au.Id == command.ApplicationUserId, cancellationToken);

            if (applicationUser == null)
                return Result.Failure($"ApplicationUser with ID '{command.ApplicationUserId}' not found");

            if (applicationUser.SchoolUsers.Count > 0)
                return Result.Failure(
                    $"Cannot delete ApplicationUser with {applicationUser.SchoolUsers.Count} linked SchoolUser(s). " +
                    "Delete all linked SchoolUsers first.");

            dbContext.ApplicationUsers.Remove(applicationUser);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
