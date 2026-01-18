using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.School
{
    public class GetSchoolQuery : IRequest<SchoolDto?>
    {
        public required long SchoolId { get; set; }
    }

    public class GetSchoolQueryHandler : IRequestHandler<GetSchoolQuery, SchoolDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetSchoolQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<SchoolDto?> Handle(GetSchoolQuery request, CancellationToken cancellationToken)
        {
            var school = await _dbContext.Schools
                .SingleOrDefaultAsync(s => s.Id == request.SchoolId, cancellationToken);

            return school?.ToDto();
        }
    }
}
