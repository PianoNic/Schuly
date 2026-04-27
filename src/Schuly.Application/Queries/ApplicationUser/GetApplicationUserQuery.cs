using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.ApplicationUser
{
    public record GetApplicationUserQuery(Guid ApplicationUserId) : IQuery<Result<ApplicationUserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Administrator;
    }

    public class GetApplicationUserQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetApplicationUserQuery, Result<ApplicationUserDto>>
    {
        public async ValueTask<Result<ApplicationUserDto>> Handle(GetApplicationUserQuery query, CancellationToken cancellationToken)
        {
            var applicationUser = await dbContext.ApplicationUsers
                .Include(au => au.SchoolUsers)
                .SingleOrDefaultAsync(au => au.Id == query.ApplicationUserId, cancellationToken);

            if (applicationUser == null)
                return Result<ApplicationUserDto>.Failure($"ApplicationUser with ID '{query.ApplicationUserId}' not found");

            return Result<ApplicationUserDto>.Success(applicationUser.ToDto());
        }
    }
}
