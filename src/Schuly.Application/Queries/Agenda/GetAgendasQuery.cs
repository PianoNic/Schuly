using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Agenda
{
    public record GetAgendasQuery() : IQuery<Result<List<AgendaEntryDto>>>;

    public class GetAgendasQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetAgendasQuery, Result<List<AgendaEntryDto>>>
    {
        public async ValueTask<Result<List<AgendaEntryDto>>> Handle(GetAgendasQuery query, CancellationToken cancellationToken)
        {
            var agendaEntries = await dbContext.AgendaEntries.ToListAsync(cancellationToken);
            return Result<List<AgendaEntryDto>>.Success(agendaEntries.ToDto());
        }
    }
}
