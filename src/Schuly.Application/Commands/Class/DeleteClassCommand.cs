using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public class DeleteClassCommand : IRequest
    {
        public required Guid ClassId { get; set; }
    }

    public class DeleteClassCommandHandler : IRequestHandler<DeleteClassCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteClassCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteClassCommand request, CancellationToken cancellationToken)
        {
            var classEntity = await _dbContext.Classes
                .SingleOrDefaultAsync(c => c.Id == request.ClassId, cancellationToken);

            if (classEntity != null)
            {
                _dbContext.Classes.Remove(classEntity);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
