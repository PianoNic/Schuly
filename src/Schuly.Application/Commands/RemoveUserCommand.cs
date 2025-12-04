using Mediator;

namespace Schuly.Application.Commands
{
    public class RemoveUserCommand : IRequest
    {
        public RemoveUserCommand(long userId)
        {
            UserId = userId;
        }

        public long UserId { get; }
    }

    public class RemoveUserCommandHandler : IRequestHandler<RemoveUserCommand>
    {
        public ValueTask<Unit> Handle(RemoveUserCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
