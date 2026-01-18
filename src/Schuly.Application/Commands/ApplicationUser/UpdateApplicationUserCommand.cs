using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public class UpdateApplicationUserCommand : IRequest, IHasAuthorization
    {
        public required Guid ApplicationUserId { get; set; }
        public string? DisplayName { get; set; }
        public string? ProfilePictureUrl { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class UpdateApplicationUserCommandHandler : IRequestHandler<UpdateApplicationUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateApplicationUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateApplicationUserCommand request, CancellationToken cancellationToken)
        {
            // Retrieve the ApplicationUser
            var applicationUser = await _dbContext.ApplicationUsers
                .FirstOrDefaultAsync(au => au.Id == request.ApplicationUserId, cancellationToken);

            if (applicationUser == null)
                throw new InvalidOperationException($"ApplicationUser with ID '{request.ApplicationUserId}' not found.");

            // Update properties
            if (!string.IsNullOrEmpty(request.DisplayName))
                applicationUser.DisplayName = request.DisplayName;

            if (!string.IsNullOrEmpty(request.ProfilePictureUrl))
                applicationUser.ProfilePictureUrl = request.ProfilePictureUrl;

            // Save changes
            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
