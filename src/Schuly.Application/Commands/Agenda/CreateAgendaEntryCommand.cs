using Mediator;
using Schuly.Application.Models;
using Schuly.Domain;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public record CreateAgendaEntryCommand(AgendaEntryType EntryType, string Title, string? Description, string? Place, DateTime Date, Guid ClassId) : ICommand<Result>;

    public class CreateAgendaEntryCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateAgendaEntryCommand, Result>
    {
        public async ValueTask<Result> Handle(CreateAgendaEntryCommand command, CancellationToken cancellationToken)
        {
            await dbContext.AgendaEntries.AddAsync(new AgendaEntry
            {
                EntryType = command.EntryType,
                Title = command.Title,
                Description = command.Description,
                Place = command.Place,
                Date = command.Date,
                ClassId = command.ClassId
            }, cancellationToken);

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
