using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Class
{
    public record GetClassesQuery() : IQuery<Result<List<ClassDto>>>;

    public class GetClassesQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetClassesQuery, Result<List<ClassDto>>>
    {
        public async ValueTask<Result<List<ClassDto>>> Handle(GetClassesQuery query, CancellationToken cancellationToken)
        {
            var classes = await dbContext.Classes
                .Include(c => c.Students)
                    .ThenInclude(s => s.Absences)
                .Include(c => c.Students)
                    .ThenInclude(s => s.Grades)
                .Include(c => c.Agenda)
                .Include(c => c.Exams)
                    .ThenInclude(e => e.Grades)
                .ToListAsync(cancellationToken);

            return Result<List<ClassDto>>.Success(classes.ToDto());
        }
    }
}
