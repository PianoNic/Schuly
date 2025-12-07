using Mediator;

namespace Schuly.Application.Commands.User
{
    public class UpdateUserCommand : IRequest
    {
    }

    public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand>
    {
        public ValueTask<Unit> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
