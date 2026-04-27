using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public record DeleteUserCommand(Guid UserId) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class DeleteUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteUserCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteUserCommand command, CancellationToken cancellationToken)
        {
            var user = await dbContext.Users
                .SingleOrDefaultAsync(u => u.Id == command.UserId, cancellationToken);

            if (user == null)
                return Result.Failure($"User with ID '{command.UserId}' not found");

            dbContext.Users.Remove(user);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
