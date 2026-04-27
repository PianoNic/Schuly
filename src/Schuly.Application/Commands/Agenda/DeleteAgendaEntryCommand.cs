using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public record DeleteAgendaEntryCommand(Guid AgendaEntryId) : ICommand<Result>;

    public class DeleteAgendaEntryCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteAgendaEntryCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteAgendaEntryCommand command, CancellationToken cancellationToken)
        {
            var agendaEntry = await dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == command.AgendaEntryId, cancellationToken);

            if (agendaEntry == null)
                return Result.Failure($"Agenda entry with ID '{command.AgendaEntryId}' not found");

            dbContext.AgendaEntries.Remove(agendaEntry);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
