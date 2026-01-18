using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.School
{
    public class GetSchoolsQuery : IRequest<List<SchoolDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class GetSchoolsQueryHandler : IRequestHandler<GetSchoolsQuery, List<SchoolDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetSchoolsQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<SchoolDto>> Handle(GetSchoolsQuery request, CancellationToken cancellationToken)
        {
            var schools = await _dbContext.Schools.ToListAsync(cancellationToken);
            return schools.ToDto();
        }
    }
}
