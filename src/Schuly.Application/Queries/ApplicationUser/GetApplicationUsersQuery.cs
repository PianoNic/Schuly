using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.ApplicationUser
{
    public class GetApplicationUsersQuery : IRequest<List<ApplicationUserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class GetApplicationUsersQueryHandler : IRequestHandler<GetApplicationUsersQuery, List<ApplicationUserDto>>
    {
        private readonly SchulyDbContext _dbContext;

        public GetApplicationUsersQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<List<ApplicationUserDto>> Handle(GetApplicationUsersQuery request, CancellationToken cancellationToken)
        {
            var applicationUsers = await _dbContext.ApplicationUsers
                .Include(au => au.SchoolUsers)
                .ToListAsync(cancellationToken);

            return applicationUsers.ToDto();
        }
    }
}
