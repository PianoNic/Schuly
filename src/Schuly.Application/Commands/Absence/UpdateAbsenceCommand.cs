using Mediator;

namespace Schuly.Application.Commands.Absence
{
    public class UpdateAbsenceCommand : IRequest
    {
    }

    public class UpdateAbsenceCommandHandler : IRequestHandler<UpdateAbsenceCommand>
    {
        public ValueTask<Unit> Handle(UpdateAbsenceCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
