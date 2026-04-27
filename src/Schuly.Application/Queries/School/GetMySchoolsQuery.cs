using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

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
            var currentUser = await userService.GetCurrentUserAsync(cancellationToken);
            if (currentUser == null)
                return Result<List<SchoolDto>>.Failure("User not found");

            var schools = await dbContext.SchoolUsers
                .Where(su => su.ApplicationUserId == currentUser.Id)
                .Include(su => su.School)
                .Select(su => su.School!)
                .Distinct()
                .ToListAsync(cancellationToken);

            return Result<List<SchoolDto>>.Success(schools.ToDto());
        }
    }
}
