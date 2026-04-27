using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Models;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;

namespace Schuly.Application.Queries.User
{
    public record GetCurrentUserQuery() : IQuery<Result<UserDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole() => Roles.Student;
    }

    public class GetCurrentUserQueryHandler(IUserService userService) : IQueryHandler<GetCurrentUserQuery, Result<UserDto>>
    {
        public async ValueTask<Result<UserDto>> Handle(GetCurrentUserQuery query, CancellationToken cancellationToken)
        {
            var user = await userService.GetCurrentUserAsync(cancellationToken);

            if (user == null)
                return Result<UserDto>.Failure("User not found");

            return Result<UserDto>.Success(user.ToDto());
        }
    }
}
