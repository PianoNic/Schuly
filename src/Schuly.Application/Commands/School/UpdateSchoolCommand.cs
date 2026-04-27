using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.School
{
    public record UpdateSchoolCommand(
        Guid Id,
        string Name,
        string? Description,
        string? Email,
        string? PhoneNumber,
        string? Website,
        string? Street,
        string? City,
        string? State,
        string? Zip,
        string? Country) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class UpdateSchoolCommandHandler(SchulyDbContext dbContext) : ICommandHandler<UpdateSchoolCommand, Result>
    {
        public async ValueTask<Result> Handle(UpdateSchoolCommand command, CancellationToken cancellationToken)
        {
            var school = await dbContext.Schools.FindAsync([command.Id], cancellationToken: cancellationToken);

            if (school == null)
                return Result.Failure($"School with ID {command.Id} not found");

            school.Name = command.Name;
            school.Description = command.Description;
            school.Email = command.Email;
            school.PhoneNumber = command.PhoneNumber;
            school.Website = command.Website;
            school.Street = command.Street;
            school.City = command.City;
            school.State = command.State;
            school.Zip = command.Zip;
            school.Country = command.Country;

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
