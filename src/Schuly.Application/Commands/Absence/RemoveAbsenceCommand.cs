using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public class RemoveAbsenceCommand : IRequest
    {
        public required long AbsenceId { get; set; }
    }

    public class RemoveAbsenceCommandHandler : IRequestHandler<RemoveAbsenceCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public RemoveAbsenceCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(RemoveAbsenceCommand request, CancellationToken cancellationToken)
        {
            var absence = await _dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == request.AbsenceId, cancellationToken);

            if (absence != null)
            {
                _dbContext.Absences.Remove(absence);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
