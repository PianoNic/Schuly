using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.SchoolUser
{
    public record GetSchoolUsersQuery(Guid? ApplicationUserId = null) : IQuery<Result<List<SchoolUserDto>>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Teacher;
    }

    public class GetSchoolUsersQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetSchoolUsersQuery, Result<List<SchoolUserDto>>>
    {
        public async ValueTask<Result<List<SchoolUserDto>>> Handle(GetSchoolUsersQuery query, CancellationToken cancellationToken)
        {
            var dbQuery = dbContext.SchoolUsers
                .Include(su => su.Absences)
                .Include(su => su.Grades)
                .Include(su => su.Classes)
                .AsQueryable();

            if (query.ApplicationUserId.HasValue)
                dbQuery = dbQuery.Where(su => su.ApplicationUserId == query.ApplicationUserId.Value);

            var schoolUsers = await dbQuery.ToListAsync(cancellationToken);
            return Result<List<SchoolUserDto>>.Success(schoolUsers.ToDto());
        }
    }
}
