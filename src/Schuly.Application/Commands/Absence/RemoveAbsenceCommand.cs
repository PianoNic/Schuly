using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public record RemoveAbsenceCommand(Guid AbsenceId) : ICommand<Result>;

    public class RemoveAbsenceCommandHandler(SchulyDbContext dbContext) : ICommandHandler<RemoveAbsenceCommand, Result>
    {
        public async ValueTask<Result> Handle(RemoveAbsenceCommand command, CancellationToken cancellationToken)
        {
            var absence = await dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == command.AbsenceId, cancellationToken);

            if (absence == null)
                return Result.Failure($"Absence with ID '{command.AbsenceId}' not found");

            dbContext.Absences.Remove(absence);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
