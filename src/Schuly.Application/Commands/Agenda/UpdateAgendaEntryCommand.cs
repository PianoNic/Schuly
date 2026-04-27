using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public record UpdateAgendaEntryCommand(Guid AgendaEntryId, AgendaEntryType EntryType, string Title, string? Description, string? Place, DateTime Date, Guid ClassId) : ICommand<Result>;

    public class UpdateAgendaEntryCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateAgendaEntryCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateAgendaEntryCommand command, CancellationToken cancellationToken)
        {
            var agendaEntry = await dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == command.AgendaEntryId, cancellationToken);

            if (agendaEntry == null)
                return Result.Failure($"Agenda entry with ID '{command.AgendaEntryId}' not found");

            agendaEntry.EntryType = command.EntryType;
            agendaEntry.Title = command.Title;
            agendaEntry.Description = command.Description;
            agendaEntry.Place = command.Place;
            agendaEntry.Date = command.Date;
            agendaEntry.ClassId = command.ClassId;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
