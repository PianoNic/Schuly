using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;
using Schuly.Infrastructure.Services;

namespace Schuly.Application.Queries.School
{
    public record GetMySchoolsQuery() : IQuery<Result<List<SchoolDto>>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Student;
    }

    public class GetMySchoolsQueryHandler(SchulyDbContext dbContext, IUserService userService) : IQueryHandler<GetMySchoolsQuery, Result<List<SchoolDto>>>
    {
        public async ValueTask<Result<List<SchoolDto>>> Handle(GetMySchoolsQuery query, CancellationToken cancellationToken)
        {
            var userId = await userService.GetCurrentUserIdAsync(cancellationToken);

            var schools = await dbContext.SchoolUsers
                .Where(su => su.ApplicationUserId == userId)
                .Include(su => su.School)
                .Select(su => su.School!)
                .Distinct()
                .ToListAsync(cancellationToken);

            return Result<List<SchoolDto>>.Success(schools.ToDto());
        }
    }
}
