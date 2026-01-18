using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace Schuly.Application.Commands.School
{
    public class DeleteSchoolCommand : IRequest, IHasAuthorization
    {
        public required long Id { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class DeleteSchoolCommandHandler : IRequestHandler<DeleteSchoolCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public DeleteSchoolCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(DeleteSchoolCommand request, CancellationToken cancellationToken)
        {
            var school = await _dbContext.Schools
                .Include(s => s.SchoolUsers)
                .Include(s => s.Classes)
                .Include(s => s.Users)
                .FirstOrDefaultAsync(s => s.Id == request.Id, cancellationToken: cancellationToken);

            if (school == null)
                throw new InvalidOperationException($"School with ID {request.Id} not found");

            if (school.SchoolUsers.Any() || school.Classes.Any() || school.Users.Any(u => u.SchoolId == request.Id))
                throw new InvalidOperationException("Cannot delete school that has associated users or classes");

            _dbContext.Schools.Remove(school);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
