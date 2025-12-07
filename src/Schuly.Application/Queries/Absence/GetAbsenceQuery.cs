using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.Absence
{
    public class GetAbsenceQuery : IRequest<AbsenceDto?>
    {
        public required long AbsenceId { get; set; }
    }

    public class GetAbsenceQueryHandler : IRequestHandler<GetAbsenceQuery, AbsenceDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetAbsenceQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<AbsenceDto?> Handle(GetAbsenceQuery request, CancellationToken cancellationToken)
        {
            var absence = await _dbContext.Absences
                .SingleOrDefaultAsync(a => a.Id == request.AbsenceId, cancellationToken);

            return absence?.ToDto();
        }
    }
}
