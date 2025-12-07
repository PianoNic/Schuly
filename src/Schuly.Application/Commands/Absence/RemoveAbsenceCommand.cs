using Mediator;

namespace Schuly.Application.Commands.Absence
{
    public class RemoveAbsenceCommand : IRequest
    {
    }

    public class RemoveAbsenceCommandHandler : IRequestHandler<RemoveAbsenceCommand>
    {
        public ValueTask<Unit> Handle(RemoveAbsenceCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
