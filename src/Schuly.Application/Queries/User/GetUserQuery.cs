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
    public record GetUserQuery(Guid UserId) : IQuery<Result<UserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Student;
    }

    public class GetUserQueryHandler(SchulyDbContext dbContext) : IQueryHandler<GetUserQuery, Result<UserDto>>
    {
        public async ValueTask<Result<UserDto>> Handle(GetUserQuery query, CancellationToken cancellationToken)
        {
            var user = await dbContext.Users
                .Include(u => u.Absences)
                .Include(u => u.Grades)
                .Include(u => u.Classes)
                .SingleOrDefaultAsync(u => u.Id == query.UserId, cancellationToken);

            if (user == null)
                return Result<UserDto>.Failure($"User with ID '{query.UserId}' not found");

            return Result<UserDto>.Success(user.ToDto());
        }
    }
}
