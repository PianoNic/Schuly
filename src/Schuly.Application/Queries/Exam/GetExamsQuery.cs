using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Exam
{
    public record GetExamsQuery() : IQuery<Result<List<ExamDto>>>;

    public class GetExamsQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetExamsQuery, Result<List<ExamDto>>>
    {
        public async ValueTask<Result<List<ExamDto>>> Handle(GetExamsQuery query, CancellationToken cancellationToken)
        {
            var exams = await dbContext.Exams
                .Include(e => e.Grades)
                .ToListAsync(cancellationToken);

            return Result<List<ExamDto>>.Success(exams.ToDto());
        }
    }
}
