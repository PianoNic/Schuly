using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public class DeleteApplicationUserCommand : IRequest, IHasAuthorization
    {
        public required Guid ApplicationUserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class DeleteApplicationUserCommandHandler : IRequestHandler<DeleteApplicationUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteApplicationUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteApplicationUserCommand request, CancellationToken cancellationToken)
        {
            // Retrieve the ApplicationUser with its SchoolUsers
            var applicationUser = await _dbContext.ApplicationUsers
                .Include(au => au.SchoolUsers)
                .FirstOrDefaultAsync(au => au.Id == request.ApplicationUserId, cancellationToken);

            if (applicationUser == null)
                throw new InvalidOperationException($"ApplicationUser with ID '{request.ApplicationUserId}' not found.");

            // Prevent deletion if SchoolUsers are linked
            if (applicationUser.SchoolUsers.Count > 0)
                throw new InvalidOperationException(
                    $"Cannot delete ApplicationUser with {applicationUser.SchoolUsers.Count} linked SchoolUser(s). " +
                    "Delete all linked SchoolUsers first.");

            // Delete the ApplicationUser
            _dbContext.ApplicationUsers.Remove(applicationUser);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
