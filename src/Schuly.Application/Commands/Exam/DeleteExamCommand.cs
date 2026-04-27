using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public record DeleteExamCommand(Guid ExamId) : ICommand<Result>;

    public class DeleteExamCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteExamCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteExamCommand command, CancellationToken cancellationToken)
        {
            var exam = await dbContext.Exams
                .SingleOrDefaultAsync(e => e.Id == command.ExamId, cancellationToken);

            if (exam == null)
                return Result.Failure($"Exam with ID '{command.ExamId}' not found");

            dbContext.Exams.Remove(exam);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
