using Mediator;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Schuly.Plugin.Abstractions;

namespace Schuly.Application.Behaviors
{
    public class PluginEventBehavior<TRequest, TResponse>(IServiceProvider serviceProvider, ILogger<PluginEventBehavior<TRequest, TResponse>> logger) : IPipelineBehavior<TRequest, TResponse>
        where TRequest : notnull, IMessage
    {
        public async ValueTask<TResponse> Handle(
            TRequest request,
            MessageHandlerDelegate<TRequest, TResponse> next,
            CancellationToken cancellationToken)
        {
            var response = await next(request, cancellationToken);

            if (IsSuccessResult(response))
            {
                _ = Task.Run(async () =>
                {
                    try
                    {
                        using var scope = serviceProvider.CreateScope();
                        var handlers = scope.ServiceProvider.GetServices<IPluginEventHandler<TRequest>>();

                        foreach (var handler in handlers)
                        {
                            try
                            {
                                await handler.HandleAsync(request, CancellationToken.None);
                            }
                            catch (Exception ex)
                            {
                                logger.LogError(ex, "Plugin event handler {Handler} failed for {Command}", handler.GetType().Name, typeof(TRequest).Name);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        logger.LogError(ex, "Plugin event dispatch failed for {Command}", typeof(TRequest).Name);
                    }
                }, CancellationToken.None);
            }

            return response;
        }

        private static bool IsSuccessResult(TResponse response)
        {
            if (response is Models.Result result)
                return result.IsSuccess;

            var type = typeof(TResponse);
            if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Models.Result<>))
            {
                var prop = type.GetProperty("IsSuccess");
                return prop?.GetValue(response) is true;
            }

            return false;
        }
    }
}
