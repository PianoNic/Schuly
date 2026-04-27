using Mediator;
using Schuly.Application.Authorization;

namespace Schuly.Application.Behaviors
{
    public class AuthorizationBehavior<TRequest, TResponse>(IAppAuthorizationService authorizationService) : IPipelineBehavior<TRequest, TResponse>
        where TRequest : notnull, IMessage
    {
        public async ValueTask<TResponse> Handle(
            TRequest request,
            MessageHandlerDelegate<TRequest, TResponse> next,
            CancellationToken cancellationToken)
        {
            await authorizationService.CanAuthorizeAsync(request);

            return await next(request, cancellationToken);
        }
    }
}
