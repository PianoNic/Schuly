using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public record UpdateAbsenceCommand(long AbsenceId, string Reason, AbsenceType Type, DateTime From, DateTime Until, Guid UserId) : ICommand<Result>;

    public class UpdateAbsenceCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateAbsenceCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateAbsenceCommand command, CancellationToken cancellationToken)
        {
            var absence = await dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == command.AbsenceId, cancellationToken);

            if (absence == null)
                return Result.Failure($"Absence with ID '{command.AbsenceId}' not found");

            absence.Reason = command.Reason;
            absence.Type = command.Type;
            absence.From = command.From;
            absence.Until = command.Until;
            absence.UserId = command.UserId;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
