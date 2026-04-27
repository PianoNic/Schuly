using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public record CreateUserCommand(
        string FirstName,
        string LastName,
        string Email,
        string? PrivateEmail,
        string? PhoneNumber,
        string? Street,
        string? City,
        string? Zip,
        DateOnly Birthday,
        DateOnly EntryDate,
        Roles Role) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class CreateUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateUserCommand, Result>
    {
        public async ValueTask<Result> Handle(CreateUserCommand command, CancellationToken cancellationToken)
        {
            await dbContext.Users.AddAsync(new Domain.User
            {
                FirstName = command.FirstName,
                LastName = command.LastName,
                Email = command.Email,
                PrivateEmail = command.PrivateEmail,
                PhoneNumber = command.PhoneNumber,
                Street = command.Street,
                City = command.City,
                Zip = command.Zip,
                Birthday = command.Birthday,
                EntryDate = command.EntryDate,
                Role = command.Role
            }, cancellationToken);

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
