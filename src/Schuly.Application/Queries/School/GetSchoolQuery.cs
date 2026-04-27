using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.School
{
    public record GetSchoolQuery(long SchoolId) : IQuery<Result<SchoolDto>>;

    public class GetSchoolQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetSchoolQuery, Result<SchoolDto>>
    {
        public async ValueTask<Result<SchoolDto>> Handle(GetSchoolQuery query, CancellationToken cancellationToken)
        {
            var school = await dbContext.Schools
                .SingleOrDefaultAsync(s => s.Id == query.SchoolId, cancellationToken);

            if (school == null)
                return Result<SchoolDto>.Failure($"School with ID '{query.SchoolId}' not found");

            return Result<SchoolDto>.Success(school.ToDto());
        }
    }
}
