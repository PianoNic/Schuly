using Mediator;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Absence
{
    public class CreateAbsenceCommand : IRequest
    {
        public required string Reason { get; set; }
        public required AbsenceType Type { get; set; }
        public required DateTime From { get; set; }
        public required DateTime Until { get; set; }
        public required Guid UserId { get; set; }
    }

    public class CreateAbsenceCommandHandler : IRequestHandler<CreateAbsenceCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateAbsenceCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(CreateAbsenceCommand request, CancellationToken cancellationToken)
        {
            await _dbContext.Absences.AddAsync(new Domain.Absence
            {
                Reason = request.Reason,
                Type = request.Type,
                From = request.From,
                Until = request.Until,
                UserId = request.UserId
            }, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
