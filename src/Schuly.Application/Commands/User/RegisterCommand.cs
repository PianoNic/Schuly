using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Application.Services;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public record RegisterCommand(
        string FirstName,
        string LastName,
        string Email,
        string Password,
        DateOnly Birthday,
        DateOnly EntryDate,
        Roles Role = Roles.Student) : ICommand<Result<LoginDto>>;

    public class RegisterCommandHandler(
        SchulyDbContext dbContext,
        IPasswordHashingService passwordHashingService,
        ITokenGenerationService tokenGenerationService) : ICommandHandler<RegisterCommand, Result<LoginDto>>
    {
        public async ValueTask<Result<LoginDto>> Handle(RegisterCommand command, CancellationToken cancellationToken)
        {
            var existingUser = await dbContext.Users
                .FirstOrDefaultAsync(u => u.Email == command.Email, cancellationToken);

            if (existingUser != null)
                return Result<LoginDto>.Failure("User with this email already exists");

            var (passwordHash, passwordSalt) = passwordHashingService.HashPassword(command.Password);

            var newUser = new Schuly.Domain.User
            {
                Id = Guid.NewGuid(),
                FirstName = command.FirstName,
                LastName = command.LastName,
                Email = command.Email,
                Birthday = command.Birthday,
                EntryDate = command.EntryDate,
                Role = command.Role,
                State = UserState.Active,
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt
            };

            dbContext.Users.Add(newUser);
            await dbContext.SaveChangesAsync(cancellationToken);

            var token = tokenGenerationService.GenerateJwtToken(newUser);

            return Result<LoginDto>.Success(new LoginDto(
                token,
                new UserLoginDto(newUser.Id, newUser.FirstName, newUser.LastName, newUser.Email, newUser.Role.ToString())
            ));
        }
    }
}
