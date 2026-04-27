using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public record CreateExamCommand(string Name, string? Description, ExamType Type, Guid ClassId) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Teacher;
    }

    public class CreateExamCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateExamCommand, Result>
    {
        public async ValueTask<Result> Handle(CreateExamCommand command, CancellationToken cancellationToken)
        {
            await dbContext.Exams.AddAsync(new Domain.Exam
            {
                Name = command.Name,
                Description = command.Description,
                Type = command.Type,
                ClassId = command.ClassId
            }, cancellationToken);

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
