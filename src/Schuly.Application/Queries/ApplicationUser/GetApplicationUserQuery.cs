using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.ApplicationUser
{
    public class GetApplicationUserQuery : IRequest<ApplicationUserDto?>, IHasAuthorization
    {
        public required Guid ApplicationUserId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class GetApplicationUserQueryHandler : IRequestHandler<GetApplicationUserQuery, ApplicationUserDto?>
    {
        private readonly SchulyDbContext _dbContext;

        public GetApplicationUserQueryHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<ApplicationUserDto?> Handle(GetApplicationUserQuery request, CancellationToken cancellationToken)
        {
            var applicationUser = await _dbContext.ApplicationUsers
                .Include(au => au.SchoolUsers)
                .SingleOrDefaultAsync(au => au.Id == request.ApplicationUserId, cancellationToken);

            return applicationUser?.ToDto();
        }
    }
}
