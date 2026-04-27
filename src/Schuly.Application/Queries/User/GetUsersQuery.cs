using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.User
{
    public record GetUsersQuery() : IQuery<Result<List<UserDto>>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Teacher;
    }

    public class GetUsersQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetUsersQuery, Result<List<UserDto>>>
    {
        public async ValueTask<Result<List<UserDto>>> Handle(GetUsersQuery query, CancellationToken cancellationToken)
        {
            var users = await dbContext.Users
                .Include(u => u.Absences)
                .Include(u => u.Grades)
                .Include(u => u.Classes)
                .ToListAsync(cancellationToken);

            return Result<List<UserDto>>.Success(users.ToDto());
        }
    }
}
