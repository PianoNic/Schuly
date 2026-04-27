using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public record UpdateUserCommand(
        Guid UserId,
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
        DateOnly? LeaveDate,
        Roles Role) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class UpdateUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateUserCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateUserCommand command, CancellationToken cancellationToken)
        {
            var user = await dbContext.Users
                .SingleOrDefaultAsync(u => u.Id == command.UserId, cancellationToken);

            if (user == null)
                return Result.Failure($"User with ID '{command.UserId}' not found");

            user.FirstName = command.FirstName;
            user.LastName = command.LastName;
            user.Email = command.Email;
            user.PrivateEmail = command.PrivateEmail;
            user.PhoneNumber = command.PhoneNumber;
            user.Street = command.Street;
            user.City = command.City;
            user.Zip = command.Zip;
            user.Birthday = command.Birthday;
            user.EntryDate = command.EntryDate;
            user.LeaveDate = command.LeaveDate;
            user.Role = command.Role;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
