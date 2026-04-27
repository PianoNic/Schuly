using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Infrastructure;
using Schuly.Infrastructure.Services;

namespace Schuly.Application.Queries.User
{
    public record GetCurrentUserQuery() : IQuery<Result<ApplicationUserDto>>;

    public class GetCurrentUserQueryHandler(IUserService userService, SchulyDbContext dbContext) : IQueryHandler<GetCurrentUserQuery, Result<ApplicationUserDto>>
    {
        public async ValueTask<Result<ApplicationUserDto>> Handle(GetCurrentUserQuery query, CancellationToken cancellationToken)
        {
            var userId = await userService.GetCurrentUserIdAsync(cancellationToken);
            var user = await dbContext.ApplicationUsers
                .Include(u => u.SchoolUsers)
                .SingleOrDefaultAsync(u => u.Id == userId, cancellationToken);

            if (user == null)
                return Result<ApplicationUserDto>.Failure("User not found");

            return Result<ApplicationUserDto>.Success(user.ToDto());
        }
    }
}
