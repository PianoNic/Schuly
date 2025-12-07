using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public class UpdateClassCommand : IRequest
    {
        public required Guid ClassId { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
    }

    public class UpdateClassCommandHandler : IRequestHandler<UpdateClassCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateClassCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateClassCommand request, CancellationToken cancellationToken)
        {
            var classEntity = await _dbContext.Classes
                .SingleOrDefaultAsync(c => c.Id == request.ClassId, cancellationToken);

            if (classEntity != null)
            {
                classEntity.Name = request.Name;
                classEntity.Description = request.Description;

                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
