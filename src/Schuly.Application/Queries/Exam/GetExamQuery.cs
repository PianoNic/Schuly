using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Exam
{
    public class GetExamQuery : IRequest<ExamDto?>
    {
        public required long ExamId { get; set; }
    }

    public class GetExamQueryHandler : IRequestHandler<GetExamQuery, ExamDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetExamQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<ExamDto?> Handle(GetExamQuery request, CancellationToken cancellationToken)
        {
            var exam = await _dbContext.Exams
                .Include(e => e.Grades)
                .SingleOrDefaultAsync(e => e.Id == request.ExamId, cancellationToken);

            return exam?.ToDto();
        }
    }
}
