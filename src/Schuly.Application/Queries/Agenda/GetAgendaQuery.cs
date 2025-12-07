using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Agenda
{
    public class GetAgendaQuery : IRequest<AgendaEntryDto?>
    {
        public required long AgendaEntryId { get; set; }
    }

    public class GetAgendaQueryHandler : IRequestHandler<GetAgendaQuery, AgendaEntryDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetAgendaQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<AgendaEntryDto?> Handle(GetAgendaQuery request, CancellationToken cancellationToken)
        {
            var agendaEntry = await _dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == request.AgendaEntryId, cancellationToken);

            return agendaEntry?.ToDto();
        }
    }
}
