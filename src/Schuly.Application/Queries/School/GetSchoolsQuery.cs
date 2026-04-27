using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.School
{
    public record GetSchoolsQuery() : IQuery<Result<List<SchoolDto>>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class GetSchoolsQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetSchoolsQuery, Result<List<SchoolDto>>>
    {
        public async ValueTask<Result<List<SchoolDto>>> Handle(GetSchoolsQuery query, CancellationToken cancellationToken)
        {
            var schools = await dbContext.Schools.ToListAsync(cancellationToken);
            return Result<List<SchoolDto>>.Success(schools.ToDto());
        }
    }
}
