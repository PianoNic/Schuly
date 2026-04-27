using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Absence
{
    public record GetAbsencesQuery() : IQuery<Result<List<AbsenceDto>>>;

    public class GetAbsencesQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetAbsencesQuery, Result<List<AbsenceDto>>>
    {
        public async ValueTask<Result<List<AbsenceDto>>> Handle(GetAbsencesQuery query, CancellationToken cancellationToken)
        {
            var absences = await dbContext.Absences.ToListAsync(cancellationToken);
            return Result<List<AbsenceDto>>.Success(absences.ToDto());
        }
    }
}
