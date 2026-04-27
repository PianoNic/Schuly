using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.School
{
    public record DeleteSchoolCommand(Guid Id) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class DeleteSchoolCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteSchoolCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteSchoolCommand command, CancellationToken cancellationToken)
        {
            var school = await dbContext.Schools
                .Include(s => s.SchoolUsers)
                .Include(s => s.Classes)
                .FirstOrDefaultAsync(s => s.Id == command.Id, cancellationToken: cancellationToken);

            if (school == null)
                return Result.Failure($"School with ID {command.Id} not found");

            if (school.SchoolUsers.Any() || school.Classes.Any())
                return Result.Failure("Cannot delete school that has associated users or classes");

            dbContext.Schools.Remove(school);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
