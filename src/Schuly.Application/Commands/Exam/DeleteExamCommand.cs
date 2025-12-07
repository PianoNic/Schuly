using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public class DeleteExamCommand : IRequest
    {
        public required long ExamId { get; set; }
    }

    public class DeleteExamCommandHandler : IRequestHandler<DeleteExamCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteExamCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteExamCommand request, CancellationToken cancellationToken)
        {
            var exam = await _dbContext.Exams
                .SingleOrDefaultAsync(e => e.Id == request.ExamId, cancellationToken);

            if (exam != null)
            {
                _dbContext.Exams.Remove(exam);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
