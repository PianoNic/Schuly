using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public class CreateClassCommand : IRequest, IHasAuthorization
    {
        public required string Name { get; set; }
        public string? Description { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Teacher;
        }
    }

    public class CreateClassCommandHandler : IRequestHandler<CreateClassCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateClassCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(CreateClassCommand request, CancellationToken cancellationToken)
        {
            await _dbContext.Classes.AddAsync(new Domain.Class
            {
                Name = request.Name,
                Description = request.Description
            }, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
