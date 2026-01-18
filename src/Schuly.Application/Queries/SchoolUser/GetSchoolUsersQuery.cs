using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.SchoolUser
{
    public class GetSchoolUsersQuery : IRequest<List<SchoolUserDto>>, IHasAuthorization
    {
        public Guid? ApplicationUserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Teacher;
        }
    }

    public class GetSchoolUsersQueryHandler : IRequestHandler<GetSchoolUsersQuery, List<SchoolUserDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetSchoolUsersQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<SchoolUserDto>> Handle(GetSchoolUsersQuery request, CancellationToken cancellationToken)
        {
            var query = _dbContext.SchoolUsers
                .Include(su => su.Absences)
                .Include(su => su.Grades)
                .Include(su => su.Classes)
                .AsQueryable();

            if (request.ApplicationUserId.HasValue)
            {
                query = query.Where(su => su.ApplicationUserId == request.ApplicationUserId.Value);
            }

            var schoolUsers = await query.ToListAsync(cancellationToken);
            return schoolUsers.ToDto();
        }
    }
}
