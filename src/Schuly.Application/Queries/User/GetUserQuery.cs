using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.User
{
    public class GetUserQuery : IRequest<UserDto?>
    {
        public required Guid UserId { get; set; }
    }

    public class GetUserQueryHandler : IRequestHandler<GetUserQuery, UserDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetUserQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<UserDto?> Handle(GetUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users
                .Include(u => u.Absences)
                .Include(u => u.Grades)
                .SingleOrDefaultAsync(u => u.Id == request.UserId, cancellationToken);

            return user?.ToDto();
        }
    }
}
