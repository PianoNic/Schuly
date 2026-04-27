using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public record DeleteClassCommand(Guid ClassId) : ICommand<Result>;

    public class DeleteClassCommandHandler(SchulyDbContext dbContext) : ICommandHandler<DeleteClassCommand, Result>
    {
        public async ValueTask<Result> Handle(DeleteClassCommand command, CancellationToken cancellationToken)
        {
            var classEntity = await dbContext.Classes
                .SingleOrDefaultAsync(c => c.Id == command.ClassId, cancellationToken);

            if (classEntity == null)
                return Result.Failure($"Class with ID '{command.ClassId}' not found");

            dbContext.Classes.Remove(classEntity);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
