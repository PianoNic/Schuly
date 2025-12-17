using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class EnableTwoFactorCommand : IRequest<EnableTwoFactorResponse>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class EnableTwoFactorResponse
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
        public string? Secret { get; set; }
        public string? QrCodeUri { get; set; }
    }

    public class EnableTwoFactorCommandHandler : IRequestHandler<EnableTwoFactorCommand, EnableTwoFactorResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly ITwoFactorService _twoFactorService;
        private readonly IUserService _userService;

        public EnableTwoFactorCommandHandler(
            SchulyDbContext dbContext,
            ITwoFactorService twoFactorService,
            IUserService userService)
        {
            _dbContext = dbContext;
            _twoFactorService = twoFactorService;
            _userService = userService;
        }

        public async ValueTask<EnableTwoFactorResponse> Handle(EnableTwoFactorCommand request, CancellationToken cancellationToken)
        {
            var user = await _userService.GetCurrentUserAsync(cancellationToken);
            if (user == null)
            {
                return new EnableTwoFactorResponse
                {
                    Success = false,
                    Message = "User not found"
                };
            }

            if (user.TwoFactorEnabled)
            {
                return new EnableTwoFactorResponse
                {
                    Success = false,
                    Message = "Two-factor authentication is already enabled"
                };
            }

            var secret = _twoFactorService.GenerateTotpSecret();
            var qrCodeUri = _twoFactorService.GenerateQrCodeUri(user.Email, secret);

            user.TwoFactorSecret = secret;
            _dbContext.Users.Update(user);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return new EnableTwoFactorResponse
            {
                Success = true,
                Message = "Two-factor secret generated. Scan the QR code with an authenticator app.",
                Secret = secret,
                QrCodeUri = qrCodeUri
            };
        }
    }
}
