using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public record DeleteSchoolUserCommand(long SchoolUserId) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class DeleteSchoolUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteSchoolUserCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteSchoolUserCommand command, CancellationToken cancellationToken)
        {
            var schoolUser = await dbContext.SchoolUsers
                .FirstOrDefaultAsync(su => su.Id == command.SchoolUserId, cancellationToken);

            if (schoolUser == null)
                return Result.Failure($"SchoolUser with ID '{command.SchoolUserId}' not found");

            dbContext.SchoolUsers.Remove(schoolUser);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
