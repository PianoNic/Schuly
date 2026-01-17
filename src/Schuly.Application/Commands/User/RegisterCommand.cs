using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Services;
using Schuly.Domain;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class RegisterCommand : IRequest<RegisterResponse>
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public DateOnly Birthday { get; set; }
        public DateOnly EntryDate { get; set; }
        public Roles Role { get; set; } = Roles.Student;
    }

    public class RegisterResponse
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
        public UserLoginDto? User { get; set; }
    }

    public class UserRegisterDto
    {
        public Guid Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
    }

    public class RegisterCommandHandler : IRequestHandler<RegisterCommand, RegisterResponse>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly IPasswordHashingService _passwordHashingService;
        private readonly ITokenGenerationService _tokenGenerationService;

        public RegisterCommandHandler(
            SchulyDbContext dbContext,
            IPasswordHashingService passwordHashingService,
            ITokenGenerationService tokenGenerationService)
        {
            _dbContext = dbContext;
            _passwordHashingService = passwordHashingService;
            _tokenGenerationService = tokenGenerationService;
        }

        public async ValueTask<RegisterResponse> Handle(RegisterCommand request, CancellationToken cancellationToken)
        {
            var existingUser = await _dbContext.Users
                .FirstOrDefaultAsync(u => u.Email == request.Email, cancellationToken);

            if (existingUser != null)
            {
                return new RegisterResponse
                {
                    Success = false,
                    Message = "User with this email already exists"
                };
            }

            var (passwordHash, passwordSalt) = _passwordHashingService.HashPassword(request.Password);

            var newUser = new Schuly.Domain.User
            {
                Id = Guid.NewGuid(),
                FirstName = request.FirstName,
                LastName = request.LastName,
                Email = request.Email,
                Birthday = request.Birthday,
                EntryDate = request.EntryDate,
                Role = request.Role,
                State = UserState.Active,
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt
            };

            _dbContext.Users.Add(newUser);
            await _dbContext.SaveChangesAsync(cancellationToken);

            var token = _tokenGenerationService.GenerateJwtToken(newUser);

            return new RegisterResponse
            {
                Success = true,
                Message = "User registered successfully",
                User = new UserLoginDto
                {
                    Id = newUser.Id,
                    FirstName = newUser.FirstName,
                    LastName = newUser.LastName,
                    Email = newUser.Email,
                    Role = newUser.Role.ToString()
                }
            };
        }
    }
}
