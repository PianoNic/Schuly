using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;

namespace Schuly.Application.Queries.User
{
    public class GetTwoFactorStatusQuery : IRequest<TwoFactorStatusDto>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class TwoFactorStatusDto
    {
        public bool TwoFactorEnabled { get; set; }
        public DateTime? TwoFactorEnabledAt { get; set; }
    }

    public class GetTwoFactorStatusQueryHandler : IRequestHandler<GetTwoFactorStatusQuery, TwoFactorStatusDto>
    {
        private readonly IUserService _userService;

        public GetTwoFactorStatusQueryHandler(IUserService userService)
        {
            _userService = userService;
        }

        public async ValueTask<TwoFactorStatusDto> Handle(GetTwoFactorStatusQuery request, CancellationToken cancellationToken)
        {
            var user = await _userService.GetCurrentUserAsync(cancellationToken);

            if (user == null)
            {
                return new TwoFactorStatusDto
                {
                    TwoFactorEnabled = false
                };
            }

            return new TwoFactorStatusDto
            {
                TwoFactorEnabled = user.TwoFactorEnabled,
                TwoFactorEnabledAt = user.TwoFactorEnabledAt
            };
        }
    }
}
