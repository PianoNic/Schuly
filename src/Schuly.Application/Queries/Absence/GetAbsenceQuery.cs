using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Absence
{
    public record GetAbsenceQuery(Guid AbsenceId) : IQuery<Result<AbsenceDto>>;

    public class GetAbsenceQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetAbsenceQuery, Result<AbsenceDto>>
    {
        public async ValueTask<Result<AbsenceDto>> Handle(GetAbsenceQuery query, CancellationToken cancellationToken)
        {
            var absence = await dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == query.AbsenceId, cancellationToken);

            if (absence == null)
                return Result<AbsenceDto>.Failure($"Absence with ID '{query.AbsenceId}' not found");

            return Result<AbsenceDto>.Success(absence.ToDto());
        }
    }
}
