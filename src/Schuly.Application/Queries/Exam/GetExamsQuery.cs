using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Exam
{
    public class GetExamsQuery : IRequest<List<ExamDto>>
    {
    }

    public class GetExamsQueryHandler : IRequestHandler<GetExamsQuery, List<ExamDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetExamsQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<ExamDto>> Handle(GetExamsQuery request, CancellationToken cancellationToken)
        {
            var exams = await _dbContext.Exams
                .Include(e => e.Grades)
                .ToListAsync(cancellationToken);
            return exams.ToDto();
        }
    }
}
