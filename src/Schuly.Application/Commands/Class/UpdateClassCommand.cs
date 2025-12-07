using Mediator;

namespace Schuly.Application.Commands.Class
{
    public class UpdateClassCommand : IRequest
    {
    }

    public class UpdateClassCommandHandler : IRequestHandler<UpdateClassCommand>
    {
        public ValueTask<Unit> Handle(UpdateClassCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
