using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Agenda
{
    public class DeleteAgendaEntryCommand : IRequest
    {
        public required long AgendaEntryId { get; set; }
    }

    public class DeleteAgendaEntryCommandHandler : IRequestHandler<DeleteAgendaEntryCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteAgendaEntryCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteAgendaEntryCommand request, CancellationToken cancellationToken)
        {
            var agendaEntry = await _dbContext.AgendaEntries
                .SingleOrDefaultAsync(a => a.Id == request.AgendaEntryId, cancellationToken);

            if (agendaEntry != null)
            {
                _dbContext.AgendaEntries.Remove(agendaEntry);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
