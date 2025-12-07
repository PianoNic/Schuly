using Mediator;

namespace Schuly.Application.Commands.Agenda
{
    public class CreateAgendaEntryCommand : IRequest
    {
    }

    public class CreateAgendaEntryCommandHandler : IRequestHandler<CreateAgendaEntryCommand>
    {
        public ValueTask<Unit> Handle(CreateAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
