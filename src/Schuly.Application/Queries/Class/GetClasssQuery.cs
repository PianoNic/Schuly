using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Class
{
    public class GetClasssQuery : IRequest<List<ClassDto>>
    {
    }

    public class GetClasssQueryHandler : IRequestHandler<GetClasssQuery, List<ClassDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetClasssQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<ClassDto>> Handle(GetClasssQuery request, CancellationToken cancellationToken)
        {
            var classes = await _dbContext.Classes
                .Include(c => c.Students)
                    .ThenInclude(s => s.Absences)
                .Include(c => c.Students)
                    .ThenInclude(s => s.Grades)
                .Include(c => c.Agenda)
                .Include(c => c.Exams)
                    .ThenInclude(e => e.Grades)
                .ToListAsync(cancellationToken);
            return classes.ToDto();
        }
    }
}
