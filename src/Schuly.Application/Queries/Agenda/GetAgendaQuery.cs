using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Agenda
{
    public record GetAgendaQuery(long AgendaEntryId) : IQuery<Result<AgendaEntryDto>>;

    public class GetAgendaQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetAgendaQuery, Result<AgendaEntryDto>>
    {
        public async ValueTask<Result<AgendaEntryDto>> Handle(GetAgendaQuery query, CancellationToken cancellationToken)
        {
            var agendaEntry = await dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == query.AgendaEntryId, cancellationToken);

            if (agendaEntry == null)
                return Result<AgendaEntryDto>.Failure($"Agenda entry with ID '{query.AgendaEntryId}' not found");

            return Result<AgendaEntryDto>.Success(agendaEntry.ToDto());
        }
    }
}
