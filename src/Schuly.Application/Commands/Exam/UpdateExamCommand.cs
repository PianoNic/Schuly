using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public record UpdateExamCommand(Guid ExamId, string Name, string? Description, ExamType Type, Guid ClassId) : ICommand<Result>;

    public class UpdateExamCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateExamCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateExamCommand command, CancellationToken cancellationToken)
        {
            var exam = await dbContext.Exams
                .SingleOrDefaultAsync(e => e.Id == command.ExamId, cancellationToken);

            if (exam == null)
                return Result.Failure($"Exam with ID '{command.ExamId}' not found");

            exam.Name = command.Name;
            exam.Description = command.Description;
            exam.Type = command.Type;
            exam.ClassId = command.ClassId;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
