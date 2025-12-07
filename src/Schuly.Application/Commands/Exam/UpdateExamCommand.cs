using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public class UpdateExamCommand : IRequest
    {
        public required long ExamId { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public ExamType Type { get; set; }
        public required decimal ClassAverage { get; set; }
        public required Guid ClassId { get; set; }
    }

    public class UpdateExamCommandHandler : IRequestHandler<UpdateExamCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateExamCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateExamCommand request, CancellationToken cancellationToken)
        {
            var exam = await _dbContext.Exams
                .SingleOrDefaultAsync(e => e.Id == request.ExamId, cancellationToken);

            if (exam != null)
            {
                exam.Name = request.Name;
                exam.Description = request.Description;
                exam.Type = request.Type;
                exam.ClassAverage = request.ClassAverage;
                exam.ClassId = request.ClassId;

                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
