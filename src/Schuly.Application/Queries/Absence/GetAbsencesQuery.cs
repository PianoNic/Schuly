using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Absence
{
    public class GetAbsencesQuery : IRequest<List<AbsenceDto>>
    {
    }

    public class GetAbsencesQueryHandler : IRequestHandler<GetAbsencesQuery, List<AbsenceDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetAbsencesQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<AbsenceDto>> Handle(GetAbsencesQuery request, CancellationToken cancellationToken)
        {
            var absences = await _dbContext.Absences.ToListAsync(cancellationToken);
            return absences.ToDto();
        }
    }
}
