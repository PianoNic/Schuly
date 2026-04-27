using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Class
{
    public record GetClassQuery(Guid ClassId) : IQuery<Result<ClassDto>>;

    public class GetClassQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetClassQuery, Result<ClassDto>>
    {
        public async ValueTask<Result<ClassDto>> Handle(GetClassQuery query, CancellationToken cancellationToken)
        {
            var classEntity = await dbContext.Classes
                .Include(c => c.Students)
                    .ThenInclude(s => s.Absences)
                .Include(c => c.Students)
                    .ThenInclude(s => s.Grades)
                .Include(c => c.Agenda)
                .Include(c => c.Exams)
                    .ThenInclude(e => e.Grades)
                .SingleOrDefaultAsync(c => c.Id == query.ClassId, cancellationToken);

            if (classEntity == null)
                return Result<ClassDto>.Failure($"Class with ID '{query.ClassId}' not found");

            return Result<ClassDto>.Success(classEntity.ToDto());
        }
    }
}
