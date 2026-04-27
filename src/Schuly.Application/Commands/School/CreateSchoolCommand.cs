using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.School
{
    public record CreateSchoolCommand(
        string Name,
        string? Description,
        string? Email,
        string? PhoneNumber,
        string? Website,
        string? Street,
        string? City,
        string? State,
        string? Zip,
        string? Country) : ICommand<Result<long>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class CreateSchoolCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateSchoolCommand, Result<long>>
    {
        public async ValueTask<Result<long>> Handle(CreateSchoolCommand command, CancellationToken cancellationToken)
        {
            var school = new Domain.School
            {
                Name = command.Name,
                Description = command.Description,
                Email = command.Email,
                PhoneNumber = command.PhoneNumber,
                Website = command.Website,
                Street = command.Street,
                City = command.City,
                State = command.State,
                Zip = command.Zip,
                Country = command.Country
            };

            await dbContext.Schools.AddAsync(school, cancellationToken);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result<long>.Success(school.Id);
        }
    }
}
