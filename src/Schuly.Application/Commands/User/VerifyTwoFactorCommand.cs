using Mediator;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Schuly.Application.Models;
using Schuly.Application.Services;
using Schuly.Application.Services.Interfaces;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class VerifyTwoFactorCommand : IRequest<VerifyTwoFactorResponse>
    {
        public required Guid SessionId { get; set; }
        public required string Code { get; set; }
    }

    public class VerifyTwoFactorResponse
    {
        public bool Success { get; set; }
        public string? Token { get; set; }
        public string? Message { get; set; }
        public UserLoginDto? User { get; set; }
        public DateTime? RetryAfter { get; set; }
    }

    public class VerifyTwoFactorCommandHandler : IRequestHandler<VerifyTwoFactorCommand, VerifyTwoFactorResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly ITwoFactorService _twoFactorService;
        private readonly ITokenGenerationService _tokenGenerationService;
        private readonly IMemoryCache _memoryCache;

        public VerifyTwoFactorCommandHandler(
            SchulyDbContext dbContext,
            ITwoFactorService twoFactorService,
            ITokenGenerationService tokenGenerationService,
            IMemoryCache memoryCache)
        {
            _dbContext = dbContext;
            _twoFactorService = twoFactorService;
            _tokenGenerationService = tokenGenerationService;
            _memoryCache = memoryCache;
        }

        public async ValueTask<VerifyTwoFactorResponse> Handle(VerifyTwoFactorCommand request, CancellationToken cancellationToken)
        {
            var sessionKey = $"2fa-session:{request.SessionId}";
            if (!_memoryCache.TryGetValue(sessionKey, out TwoFactorSession? session))
            {
                return new VerifyTwoFactorResponse
                {
                    Success = false,
                    Message = "Two-factor session expired or not found"
                };
            }

            if (session!.IsExpired)
            {
                _memoryCache.Remove(sessionKey);
                return new VerifyTwoFactorResponse
                {
                    Success = false,
                    Message = "Two-factor session expired"
                };
            }

            var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Id == session.UserId, cancellationToken);
            if (user == null)
            {
                return new VerifyTwoFactorResponse
                {
                    Success = false,
                    Message = "User not found"
                };
            }

            if (string.IsNullOrEmpty(user.TwoFactorSecret))
            {
                return new VerifyTwoFactorResponse
                {
                    Success = false,
                    Message = "Two-factor authentication not configured"
                };
            }

            if (_twoFactorService.IsRateLimited(user.Id))
            {
                var retryAfterKey = $"2fa-retry:{user.Id}";
                if (_memoryCache.TryGetValue(retryAfterKey, out DateTime? retryAfter))
                {
                    return new VerifyTwoFactorResponse
                    {
                        Success = false,
                        Message = "Too many failed attempts. Please try again later.",
                        RetryAfter = retryAfter
                    };
                }
            }

            if (!_twoFactorService.ValidateTotpCode(user.TwoFactorSecret, request.Code))
            {
                _twoFactorService.RecordFailedAttempt(user.Id);
                var attemptKey = $"2fa-attempts:{user.Id}";
                var retryAfterKey = $"2fa-retry:{user.Id}";
                var retryAfter = DateTime.UtcNow.AddMinutes(15);
                _memoryCache.Set(retryAfterKey, retryAfter, TimeSpan.FromMinutes(15));

                return new VerifyTwoFactorResponse
                {
                    Success = false,
                    Message = "Invalid two-factor code",
                    RetryAfter = retryAfter
                };
            }

            _twoFactorService.ResetAttempts(user.Id);
            _memoryCache.Remove(sessionKey);

            var token = _tokenGenerationService.GenerateJwtToken(user);

            return new VerifyTwoFactorResponse
            {
                Success = true,
                Token = token,
                User = new UserLoginDto
                {
                    Id = user.Id,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    Email = user.Email,
                    Role = user.Role.ToString()
                }
            };
        }
    }
}
