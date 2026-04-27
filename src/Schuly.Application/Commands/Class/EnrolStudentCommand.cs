using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public record EnrolStudentCommand(Guid UserId, Guid ClassId) : ICommand<Result>;

    public class EnrolStudentCommandHandler(SchulyDbContext dbContext) : ICommandHandler<EnrolStudentCommand, Result>
    {
        public async ValueTask<Result> Handle(EnrolStudentCommand command, CancellationToken cancellationToken)
        {
            var user = await dbContext.Users.SingleOrDefaultAsync(u => u.Id == command.UserId, cancellationToken);
            if (user == null)
                return Result.Failure($"User with ID '{command.UserId}' not found");

            var @class = await dbContext.Classes.AsTracking().SingleOrDefaultAsync(c => c.Id == command.ClassId, cancellationToken);
            if (@class == null)
                return Result.Failure($"Class with ID '{command.ClassId}' not found");

            @class.Students.Add(user);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
