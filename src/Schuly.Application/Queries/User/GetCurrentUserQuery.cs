using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;

namespace Schuly.Application.Queries.User
{
    public class GetCurrentUserQuery : IRequest<CurrentUserDto?>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class CurrentUserDto
    {
        public UserDto User { get; set; }
    }

    public class GetCurrentUserQueryHandler : IRequestHandler<GetCurrentUserQuery, CurrentUserDto?>
    {
        private readonly IUserService _userService;

        public GetCurrentUserQueryHandler(IUserService userService)
        {
            _userService = userService;
        }

        public async ValueTask<CurrentUserDto?> Handle(GetCurrentUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _userService.GetCurrentUserAsync(cancellationToken);

            if (user == null)
                return null;

            return new CurrentUserDto
            {
                User = user.ToDto()
            };
        }
    }
}
