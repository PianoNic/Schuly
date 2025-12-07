using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public class UpdateAgendaEntryCommand : IRequest
    {
        public required long AgendaEntryId { get; set; }
        public required AgendaEntryType EntryType { get; set; }
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? Place { get; set; }
        public required DateTime Date { get; set; }
        public required Guid ClassId { get; set; }
    }

    public class UpdateAgendaEntryCommandHandler : IRequestHandler<UpdateAgendaEntryCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateAgendaEntryCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            var agendaEntry = await _dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == request.AgendaEntryId, cancellationToken);

            if (agendaEntry != null)
            {
                agendaEntry.EntryType = request.EntryType;
                agendaEntry.Title = request.Title;
                agendaEntry.Description = request.Description;
                agendaEntry.Place = request.Place;
                agendaEntry.Date = request.Date;
                agendaEntry.ClassId = request.ClassId;

                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
