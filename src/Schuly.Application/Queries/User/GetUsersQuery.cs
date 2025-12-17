using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.User
{
    public class GetUsersQuery : IRequest<List<UserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Teacher;
        }
    }

    public class GetUsersQueryHandler : IRequestHandler<GetUsersQuery, List<UserDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetUsersQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<UserDto>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
        {
            var users = await _dbContext.Users
                .Include(u => u.Absences)
                .Include(u => u.Grades)
                .Include(u => u.Classes)
                .ToListAsync(cancellationToken);
            return users.ToDto();
        }
    }
}
