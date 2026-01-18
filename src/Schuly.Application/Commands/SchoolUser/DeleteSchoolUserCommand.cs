using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public class DeleteSchoolUserCommand : IRequest, IHasAuthorization
    {
        public required long SchoolUserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class DeleteSchoolUserCommandHandler : IRequestHandler<DeleteSchoolUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteSchoolUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteSchoolUserCommand request, CancellationToken cancellationToken)
        {
            var schoolUser = await _dbContext.SchoolUsers
                .FirstOrDefaultAsync(su => su.Id == request.SchoolUserId, cancellationToken);

            if (schoolUser == null)
                throw new InvalidOperationException($"SchoolUser with ID '{request.SchoolUserId}' not found.");

            _dbContext.SchoolUsers.Remove(schoolUser);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
