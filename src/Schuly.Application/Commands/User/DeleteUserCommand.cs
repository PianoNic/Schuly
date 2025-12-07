using Mediator;

namespace Schuly.Application.Commands.User
{
    public class DeleteUserCommand : IRequest
    {
    }

    public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand>
    {
        public ValueTask<Unit> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
