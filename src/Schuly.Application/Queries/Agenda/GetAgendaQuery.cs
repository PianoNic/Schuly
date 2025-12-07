using Mediator;

namespace Schuly.Application.Queries.Agenda
{
    public class GetAgendaQuery : IRequest
    {
    }

    public class GetAgendaQueryHandler : IRequestHandler<GetAgendaQuery>
    {
        public ValueTask<Unit> Handle(GetAgendaQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
