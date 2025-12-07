using Mediator;

namespace Schuly.Application.Commands.Absence
{
    public class CreateAbsenceCommand : IRequest
    {
    }

    public class CreateAbsenceCommandHandler : IRequestHandler<CreateAbsenceCommand>
    {
        public ValueTask<Unit> Handle(CreateAbsenceCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
