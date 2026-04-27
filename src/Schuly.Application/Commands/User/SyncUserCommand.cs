using Mediator;
using Schuly.Application.Models;
using Schuly.Infrastructure.Services;

namespace Schuly.Application.Commands.User
{
    public record SyncUserCommand() : ICommand<Result>;

    public class SyncUserCommandHandler(IUserService userService) : ICommandHandler<SyncUserCommand, Result>
    {
        public async ValueTask<Result> Handle(SyncUserCommand command, CancellationToken cancellationToken)
        {
            await userService.SyncCurrentUserAsync(cancellationToken);
            return Result.Success();
        }
    }
}
