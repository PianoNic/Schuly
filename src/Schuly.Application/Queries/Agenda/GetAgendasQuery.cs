using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Agenda
{
    public class GetAgendasQuery : IRequest<List<AgendaEntryDto>>
    {
    }

    public class GetAgendasQueryHandler : IRequestHandler<GetAgendasQuery, List<AgendaEntryDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetAgendasQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<AgendaEntryDto>> Handle(GetAgendasQuery request, CancellationToken cancellationToken)
        {
            var agendaEntries = await _dbContext.AgendaEntries.ToListAsync(cancellationToken);
            return agendaEntries.ToDto();
        }
    }
}
