using Mediator;

namespace Schuly.Application.Commands.User
{
    public class CreateUserCommand : IRequest
    {
    }

    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand>
    {
        public ValueTask<Unit> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
