using Mediator;

namespace Schuly.Application.Commands.Agenda
{
    public class UpdateAgendaEntryCommand : IRequest
    {
    }

    public class UpdateAgendaEntryCommandHandler : IRequestHandler<UpdateAgendaEntryCommand>
    {
        public ValueTask<Unit> Handle(UpdateAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
