using Mediator;

namespace Schuly.Application.Commands.Agenda
{
    public class DeleteAgendaEntryCommand : IRequest
    {
    }

    public class DeleteAgendaEntryCommandHandler : IRequestHandler<DeleteAgendaEntryCommand>
    {
        public ValueTask<Unit> Handle(DeleteAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
