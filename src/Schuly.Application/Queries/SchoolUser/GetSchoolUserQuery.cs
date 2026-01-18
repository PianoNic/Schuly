using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.SchoolUser
{
    public class GetSchoolUserQuery : IRequest<SchoolUserDto?>, IHasAuthorization
    {
        public required long SchoolUserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class GetSchoolUserQueryHandler : IRequestHandler<GetSchoolUserQuery, SchoolUserDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetSchoolUserQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<SchoolUserDto?> Handle(GetSchoolUserQuery request, CancellationToken cancellationToken)
        {
            var schoolUser = await _dbContext.SchoolUsers
                .Include(su => su.Absences)
                .Include(su => su.Grades)
                .Include(su => su.Classes)
                .SingleOrDefaultAsync(su => su.Id == request.SchoolUserId, cancellationToken);

            return schoolUser?.ToDto();
        }
    }
}
