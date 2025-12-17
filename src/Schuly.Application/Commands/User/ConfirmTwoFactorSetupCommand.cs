using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class ConfirmTwoFactorSetupCommand : IRequest<ConfirmTwoFactorSetupResponse>, IHasAuthorization
    {
        public required string Code { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class ConfirmTwoFactorSetupResponse
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
    }

    public class ConfirmTwoFactorSetupCommandHandler : IRequestHandler<ConfirmTwoFactorSetupCommand, ConfirmTwoFactorSetupResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly ITwoFactorService _twoFactorService;
        private readonly IUserService _userService;

        public ConfirmTwoFactorSetupCommandHandler(
            SchulyDbContext dbContext,
            ITwoFactorService twoFactorService,
            IUserService userService)
        {
            _dbContext = dbContext;
            _twoFactorService = twoFactorService;
            _userService = userService;
        }

        public async ValueTask<ConfirmTwoFactorSetupResponse> Handle(ConfirmTwoFactorSetupCommand request, CancellationToken cancellationToken)
        {
            var user = await _userService.GetCurrentUserAsync(cancellationToken);
            if (user == null)
            {
                return new ConfirmTwoFactorSetupResponse
                {
                    Success = false,
                    Message = "User not found"
                };
            }

            if (user.TwoFactorEnabled)
            {
                return new ConfirmTwoFactorSetupResponse
                {
                    Success = false,
                    Message = "Two-factor authentication is already enabled"
                };
            }

            if (string.IsNullOrEmpty(user.TwoFactorSecret))
            {
                return new ConfirmTwoFactorSetupResponse
                {
                    Success = false,
                    Message = "No two-factor secret configured. Call enable endpoint first."
                };
            }

            if (!_twoFactorService.ValidateTotpCode(user.TwoFactorSecret, request.Code))
            {
                return new ConfirmTwoFactorSetupResponse
                {
                    Success = false,
                    Message = "Invalid two-factor code"
                };
            }

            user.TwoFactorEnabled = true;
            user.TwoFactorEnabledAt = DateTime.UtcNow;
            _dbContext.Users.Update(user);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return new ConfirmTwoFactorSetupResponse
            {
                Success = true,
                Message = "Two-factor authentication enabled successfully"
            };
        }
    }
}
