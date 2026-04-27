using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Exam
{
    public record GetExamQuery(long ExamId) : IQuery<Result<ExamDto>>;

    public class GetExamQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetExamQuery, Result<ExamDto>>
    {
        public async ValueTask<Result<ExamDto>> Handle(GetExamQuery query, CancellationToken cancellationToken)
        {
            var exam = await dbContext.Exams
                .Include(e => e.Grades)
                .SingleOrDefaultAsync(e => e.Id == query.ExamId, cancellationToken);

            if (exam == null)
                return Result<ExamDto>.Failure($"Exam with ID '{query.ExamId}' not found");

            return Result<ExamDto>.Success(exam.ToDto());
        }
    }
}
