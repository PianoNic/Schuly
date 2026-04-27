using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Application.Services;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public record LoginCommand(string Email, string Password) : ICommand<Result<LoginDto>>;

    public record LoginDto(string Token, UserLoginDto User);

    public record UserLoginDto(Guid Id, string FirstName, string LastName, string Email, string Role);

    public class LoginCommandHandler(
        SchulyDbContext dbContext,
        IPasswordHashingService passwordHashingService,
        ITokenGenerationService tokenGenerationService) : ICommandHandler<LoginCommand, Result<LoginDto>>
    {
        public async ValueTask<Result<LoginDto>> Handle(LoginCommand command, CancellationToken cancellationToken)
        {
            var user = await dbContext.Users
                .FirstOrDefaultAsync(u => u.Email == command.Email, cancellationToken);

            if (user == null)
                return Result<LoginDto>.Failure("Invalid email or password");

            if (string.IsNullOrEmpty(user.PasswordHash) || string.IsNullOrEmpty(user.PasswordSalt))
                return Result<LoginDto>.Failure("User account is not properly configured. Please contact an administrator.");

            if (!passwordHashingService.VerifyPassword(command.Password, user.PasswordHash, user.PasswordSalt))
                return Result<LoginDto>.Failure("Invalid email or password");

            if (user.State != Schuly.Domain.Enums.UserState.Active)
                return Result<LoginDto>.Failure("User account is inactive. Please contact an administrator.");

            var token = tokenGenerationService.GenerateJwtToken(user);

            return Result<LoginDto>.Success(new LoginDto(
                token,
                new UserLoginDto(user.Id, user.FirstName, user.LastName, user.Email, user.Role.ToString())
            ));
        }
    }
}
