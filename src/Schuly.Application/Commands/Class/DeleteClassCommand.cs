using Mediator;

namespace Schuly.Application.Commands.Class
{
    public class DeleteClassCommand : IRequest
    {
    }

    public class DeleteClassCommandHandler : IRequestHandler<DeleteClassCommand>
    {
        public ValueTask<Unit> Handle(DeleteClassCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
