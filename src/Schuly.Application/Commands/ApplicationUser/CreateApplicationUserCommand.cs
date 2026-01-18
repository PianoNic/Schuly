using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public class CreateApplicationUserCommand : IRequest<Guid>, IHasAuthorization
    {
        public required string AuthenticationEmail { get; set; }
        public required string Password { get; set; }
        public string? DisplayName { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class CreateApplicationUserCommandHandler : IRequestHandler<CreateApplicationUserCommand, Guid>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly IPasswordHashingService _passwordHashingService;

        public CreateApplicationUserCommandHandler(
            SchulyDbContext dbContext,
            IPasswordHashingService passwordHashingService)
        {
            _dbContext = dbContext;
            _passwordHashingService = passwordHashingService;
        }

        public async ValueTask<Guid> Handle(CreateApplicationUserCommand request, CancellationToken cancellationToken)
        {
            // Hash the password
            var (passwordHash, passwordSalt) = _passwordHashingService.HashPassword(request.Password);

            // Create the new ApplicationUser
            var applicationUser = new Domain.ApplicationUser
            {
                Id = Guid.NewGuid(),
                AuthenticationEmail = request.AuthenticationEmail,
                DisplayName = request.DisplayName,
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt,
                IsEmailVerified = false,
                IsTwoFactorEnabled = false
            };

            // Add to database
            await _dbContext.ApplicationUsers.AddAsync(applicationUser, cancellationToken);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return applicationUser.Id;
        }
    }
}
