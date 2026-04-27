using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public record CreateSchoolUserCommand(
        Guid ApplicationUserId,
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
        Roles Role,
        string? StudentNumber,
        string? TeacherCode) : ICommand<Result<long>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class CreateSchoolUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateSchoolUserCommand, Result<long>>
    {
        public async ValueTask<Result<long>> Handle(CreateSchoolUserCommand command, CancellationToken cancellationToken)
        {
            var schoolUser = new Domain.SchoolUser
            {
                ApplicationUserId = command.ApplicationUserId,
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
                Role = command.Role,
                State = UserState.Active,
                StudentNumber = command.StudentNumber,
                TeacherCode = command.TeacherCode
            };

            await dbContext.SchoolUsers.AddAsync(schoolUser, cancellationToken);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result<long>.Success(schoolUser.Id);
        }
    }
}
