using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class DisableTwoFactorCommand : IRequest<DisableTwoFactorResponse>, IHasAuthorization
    {
        public required string Password { get; set; }
        public required string Code { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class DisableTwoFactorResponse
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
    }

    public class DisableTwoFactorCommandHandler : IRequestHandler<DisableTwoFactorCommand, DisableTwoFactorResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly ITwoFactorService _twoFactorService;
        private readonly IPasswordHashingService _passwordHashingService;
        private readonly IUserService _userService;

        public DisableTwoFactorCommandHandler(
            SchulyDbContext dbContext,
            ITwoFactorService twoFactorService,
            IPasswordHashingService passwordHashingService,
            IUserService userService)
        {
            _dbContext = dbContext;
            _twoFactorService = twoFactorService;
            _passwordHashingService = passwordHashingService;
            _userService = userService;
        }

        public async ValueTask<DisableTwoFactorResponse> Handle(DisableTwoFactorCommand request, CancellationToken cancellationToken)
        {
            var user = await _userService.GetCurrentUserAsync(cancellationToken);
            if (user == null)
            {
                return new DisableTwoFactorResponse
                {
                    Success = false,
                    Message = "User not found"
                };
            }

            if (!user.TwoFactorEnabled)
            {
                return new DisableTwoFactorResponse
                {
                    Success = false,
                    Message = "Two-factor authentication is not enabled"
                };
            }

            if (string.IsNullOrEmpty(user.PasswordHash) || string.IsNullOrEmpty(user.PasswordSalt))
            {
                return new DisableTwoFactorResponse
                {
                    Success = false,
                    Message = "User account is not properly configured"
                };
            }

            if (!_passwordHashingService.VerifyPassword(request.Password, user.PasswordHash, user.PasswordSalt))
            {
                return new DisableTwoFactorResponse
                {
                    Success = false,
                    Message = "Invalid password"
                };
            }

            if (string.IsNullOrEmpty(user.TwoFactorSecret) || !_twoFactorService.ValidateTotpCode(user.TwoFactorSecret, request.Code))
            {
                return new DisableTwoFactorResponse
                {
                    Success = false,
                    Message = "Invalid two-factor code"
                };
            }

            user.TwoFactorEnabled = false;
            user.TwoFactorSecret = null;
            user.TwoFactorEnabledAt = null;
            _dbContext.Users.Update(user);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return new DisableTwoFactorResponse
            {
                Success = true,
                Message = "Two-factor authentication disabled successfully"
            };
        }
    }
}
