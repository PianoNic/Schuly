using Mediator;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Schuly.Application.Models;
using Schuly.Application.Services;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class LoginCommand : IRequest<LoginResponse>
    {
        public required string Email { get; set; }
        public required string Password { get; set; }
    }

    public class LoginResponse
    {
        public bool Success { get; set; }
        public string? Token { get; set; }
        public string? Message { get; set; }
        public UserLoginDto? User { get; set; }
        public bool RequiresTwoFactor { get; set; }
        public Guid? TwoFactorSessionId { get; set; }
    }

    public class UserLoginDto
    {
        public Guid Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
    }

    public class LoginCommandHandler : IRequestHandler<LoginCommand, LoginResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly IPasswordHashingService _passwordHashingService;
        private readonly ITokenGenerationService _tokenGenerationService;
        private readonly IMemoryCache _memoryCache;

        public LoginCommandHandler(
            SchulyDbContext dbContext,
            IPasswordHashingService passwordHashingService,
            ITokenGenerationService tokenGenerationService,
            IMemoryCache memoryCache)
        {
            _dbContext = dbContext;
            _passwordHashingService = passwordHashingService;
            _tokenGenerationService = tokenGenerationService;
            _memoryCache = memoryCache;
        }

        public async ValueTask<LoginResponse> Handle(LoginCommand request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users
                .FirstOrDefaultAsync(u => u.Email == request.Email, cancellationToken);

            if (user == null)
            {
                return new LoginResponse
                {
                    Success = false,
                    Message = "Invalid email or password"
                };
            }

            if (string.IsNullOrEmpty(user.PasswordHash) || string.IsNullOrEmpty(user.PasswordSalt))
            {
                return new LoginResponse
                {
                    Success = false,
                    Message = "User account is not properly configured. Please contact an administrator."
                };
            }

            if (!_passwordHashingService.VerifyPassword(request.Password, user.PasswordHash, user.PasswordSalt))
            {
                return new LoginResponse
                {
                    Success = false,
                    Message = "Invalid email or password"
                };
            }

            if (user.State != Schuly.Domain.Enums.UserState.Active)
            {
                return new LoginResponse
                {
                    Success = false,
                    Message = "User account is inactive. Please contact an administrator."
                };
            }

            if (user.TwoFactorEnabled)
            {
                var sessionId = Guid.NewGuid();
                var session = new TwoFactorSession(user.Id, user.Email, TimeSpan.FromMinutes(5));
                _memoryCache.Set($"2fa-session:{sessionId}", session, TimeSpan.FromMinutes(5));

                return new LoginResponse
                {
                    Success = false,
                    RequiresTwoFactor = true,
                    TwoFactorSessionId = sessionId,
                    Message = "Two-factor authentication required"
                };
            }

            var token = _tokenGenerationService.GenerateJwtToken(user);

            return new LoginResponse
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
