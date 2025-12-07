using Mediator;
using Schuly.Domain;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public class CreateAgendaEntryCommand : IRequest
    {
        public required AgendaEntryType EntryType { get; set; }
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? Place { get; set; }
        public required DateTime Date { get; set; }
        public required Guid ClassId { get; set; }
    }

    public class CreateAgendaEntryCommandHandler : IRequestHandler<CreateAgendaEntryCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateAgendaEntryCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(CreateAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            await _dbContext.AgendaEntries.AddAsync(new AgendaEntry
            {
                EntryType = request.EntryType,
                Title = request.Title,
                Description = request.Description,
                Place = request.Place,
                Date = request.Date,
                ClassId = request.ClassId
            }, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
