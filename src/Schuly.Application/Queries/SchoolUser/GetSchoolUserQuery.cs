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
    public record GetSchoolUserQuery(Guid SchoolUserId) : IQuery<Result<SchoolUserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Student;
    }

    public class GetSchoolUserQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetSchoolUserQuery, Result<SchoolUserDto>>
    {
        public async ValueTask<Result<SchoolUserDto>> Handle(GetSchoolUserQuery query, CancellationToken cancellationToken)
        {
            var schoolUser = await dbContext.SchoolUsers
                .Include(su => su.Absences)
                .Include(su => su.Grades)
                .Include(su => su.Classes)
                .SingleOrDefaultAsync(su => su.Id == query.SchoolUserId, cancellationToken);

            if (schoolUser == null)
                return Result<SchoolUserDto>.Failure($"SchoolUser with ID '{query.SchoolUserId}' not found");

            return Result<SchoolUserDto>.Success(schoolUser.ToDto());
        }
    }
}
