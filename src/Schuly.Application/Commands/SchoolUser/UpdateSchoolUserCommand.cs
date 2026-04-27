using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public record UpdateSchoolUserCommand(
        Guid SchoolUserId,
        string? FirstName,
        string? LastName,
        string? Email,
        string? PrivateEmail,
        string? PhoneNumber,
        string? Street,
        string? City,
        string? Zip,
        DateOnly? LeaveDate,
        UserState? State) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class UpdateSchoolUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateSchoolUserCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateSchoolUserCommand command, CancellationToken cancellationToken)
        {
            var schoolUser = await dbContext.SchoolUsers
                .FirstOrDefaultAsync(su => su.Id == command.SchoolUserId, cancellationToken);

            if (schoolUser == null)
                return Result.Failure($"SchoolUser with ID '{command.SchoolUserId}' not found");

            if (!string.IsNullOrEmpty(command.FirstName))
                schoolUser.FirstName = command.FirstName;

            if (!string.IsNullOrEmpty(command.LastName))
                schoolUser.LastName = command.LastName;

            if (!string.IsNullOrEmpty(command.Email))
                schoolUser.Email = command.Email;

            if (!string.IsNullOrEmpty(command.PrivateEmail))
                schoolUser.PrivateEmail = command.PrivateEmail;

            if (!string.IsNullOrEmpty(command.PhoneNumber))
                schoolUser.PhoneNumber = command.PhoneNumber;

            if (!string.IsNullOrEmpty(command.Street))
                schoolUser.Street = command.Street;

            if (!string.IsNullOrEmpty(command.City))
                schoolUser.City = command.City;

            if (!string.IsNullOrEmpty(command.Zip))
                schoolUser.Zip = command.Zip;

            if (command.LeaveDate.HasValue)
                schoolUser.LeaveDate = command.LeaveDate;

            if (command.State.HasValue)
                schoolUser.State = command.State.Value;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
