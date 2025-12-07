using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public class UpdateAbsenceCommand : IRequest
    {
        public required long AbsenceId { get; set; }
        public required string Reason { get; set; }
        public required AbsenceType Type { get; set; }
        public required DateTime From { get; set; }
        public required DateTime Until { get; set; }
        public required Guid UserId { get; set; }
    }

    public class UpdateAbsenceCommandHandler : IRequestHandler<UpdateAbsenceCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateAbsenceCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateAbsenceCommand request, CancellationToken cancellationToken)
        {
            var absence = await _dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == request.AbsenceId, cancellationToken);

            if (absence != null)
            {
                absence.Reason = request.Reason;
                absence.Type = request.Type;
                absence.From = request.From;
                absence.Until = request.Until;
                absence.UserId = request.UserId;

                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
