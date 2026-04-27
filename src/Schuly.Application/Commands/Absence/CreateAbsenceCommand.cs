using Mediator;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public record CreateAbsenceCommand(string Reason, AbsenceType Type, DateTime From, DateTime Until, Guid SchoolUserId) : ICommand<Result>;

    public class CreateAbsenceCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateAbsenceCommand, Result>
    {
        public async ValueTask<Result> Handle(CreateAbsenceCommand command, CancellationToken cancellationToken)
        {
            await dbContext.Absences.AddAsync(new Domain.Absence
            {
                Reason = command.Reason,
                Type = command.Type,
                From = command.From,
                Until = command.Until,
                SchoolUserId = command.SchoolUserId
            }, cancellationToken);

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
