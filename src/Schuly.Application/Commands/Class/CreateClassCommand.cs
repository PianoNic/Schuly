using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Class
{
    public record CreateClassCommand(string Name, string? Description) : ICommand<Result>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Teacher;
    }

    public class CreateClassCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateClassCommand, Result>
    {
        public async ValueTask<Result> Handle(CreateClassCommand command, CancellationToken cancellationToken)
        {
            await dbContext.Classes.AddAsync(new Domain.Class
            {
                Name = command.Name,
                Description = command.Description
            }, cancellationToken);

            await dbContext.SaveChangesAsync(cancellationToken);

            return Result.Success();
        }
    }
}
