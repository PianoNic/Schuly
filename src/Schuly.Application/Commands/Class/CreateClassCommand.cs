using Mediator;

namespace Schuly.Application.Commands.Class
{
    public class CreateClassCommand : IRequest
    {
    }

    public class CreateClassCommandHandler : IRequestHandler<CreateClassCommand>
    {
        public ValueTask<Unit> Handle(CreateClassCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
