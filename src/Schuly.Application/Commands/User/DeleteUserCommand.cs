using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class DeleteUserCommand : IRequest, IHasAuthorization
    {
        public required Guid UserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users
                .SingleOrDefaultAsync(u => u.Id == request.UserId, cancellationToken);

            if (user != null)
            {
                _dbContext.Users.Remove(user);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
