using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Services.Interfaces;

namespace Schuly.Application.Behaviors
{
    public class AuthorizationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
        where TRequest : notnull, IMessage
    {
        private readonly IUserService _userService;

        public AuthorizationBehavior(IUserService userService)
        {
            _userService = userService;
        }

        public async ValueTask<TResponse> Handle(
            TRequest request,
            MessageHandlerDelegate<TRequest, TResponse> next,
            CancellationToken cancellationToken)
        {
            var authorizationService = new AuthorizationService(_userService);
            await authorizationService.CanAuthorizeAsync(request);

            return await next(request, cancellationToken);
        }
    }
}
