using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Class
{
    public class GetClassQuery : IRequest<ClassDto?>
    {
        public required Guid ClassId { get; set; }
    }

    public class GetClassQueryHandler : IRequestHandler<GetClassQuery, ClassDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetClassQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<ClassDto?> Handle(GetClassQuery request, CancellationToken cancellationToken)
        {
            var classEntity = await _dbContext.Classes
                .Include(c => c.Students)
                    .ThenInclude(s => s.Absences)
                .Include(c => c.Students)
                    .ThenInclude(s => s.Grades)
                .Include(c => c.Agenda)
                .Include(c => c.Exams)
                    .ThenInclude(e => e.Grades)
                .SingleOrDefaultAsync(c => c.Id == request.ClassId, cancellationToken);

            return classEntity?.ToDto();
        }
    }
}
