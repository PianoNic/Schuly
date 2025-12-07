using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public class AddGradeToExamCommand : IRequest
    {
        public required long ExamId { get; set; }
        public required Guid StudentId { get; set; }
        public required decimal Grade { get; set; }
        public decimal Weight { get; set; } = 1;
    }

    public class AddGradeToExamControllerHandler : IRequestHandler<AddGradeToExamCommand>
    {
        private readonly SchulyDbContext _dbContext;
        public AddGradeToExamControllerHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(AddGradeToExamCommand request, CancellationToken cancellationToken)
        {
            var exam = await _dbContext.Exams.AsTracking().SingleAsync(e => e.Id == request.ExamId, cancellationToken);

            exam.Grades.Add(new Domain.Grade()
            {
                ExamId = request.ExamId,
                UserId = request.StudentId,

                Score = request.Grade,
                Weighting = request.Weight,
            });

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
