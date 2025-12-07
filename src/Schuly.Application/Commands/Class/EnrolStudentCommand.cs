using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;
namespace Schuly.Application.Commands.Class
{
    public class EnrolStudentCommand : IRequest
    {
        public required Guid UserId {  get; set; }
        public required Guid ClassId {  get; set; }
    }

    public class EnrolStudentCommandHandler : IRequestHandler<EnrolStudentCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public EnrolStudentCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public async ValueTask<Unit> Handle(EnrolStudentCommand request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.SingleAsync(u => u.Id == request.UserId, cancellationToken);
            var @class = await _dbContext.Classes.AsTracking().SingleAsync(c => c.Id == request.ClassId, cancellationToken);

            @class.Students.Add(user);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
