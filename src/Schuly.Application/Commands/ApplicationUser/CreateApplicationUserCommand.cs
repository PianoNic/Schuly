using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.ApplicationUser
{
    public record CreateApplicationUserCommand(string AuthenticationEmail, string? DisplayName) : ICommand<Result<Guid>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class CreateApplicationUserCommandHandler(SchulyDbContext dbContext) : ICommandHandler<CreateApplicationUserCommand, Result<Guid>>
    {
        public async ValueTask<Result<Guid>> Handle(CreateApplicationUserCommand command, CancellationToken cancellationToken)
        {
            var applicationUser = new Domain.ApplicationUser
            {
                Id = Guid.NewGuid(),
                AuthenticationEmail = command.AuthenticationEmail,
                DisplayName = command.DisplayName,
                IsEmailVerified = false,
                IsTwoFactorEnabled = false
            };

            await dbContext.ApplicationUsers.AddAsync(applicationUser, cancellationToken);
            await dbContext.SaveChangesAsync(cancellationToken);

            return Result<Guid>.Success(applicationUser.Id);
        }
    }
}
