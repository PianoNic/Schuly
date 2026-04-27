using Microsoft.Extensions.Logging;
using Schuly.Application.Commands.SchoolUser;
using Schuly.Plugin.Abstractions;

namespace Schuly.Plugin.Example
{
    public class OnSchoolUserCreatedHandler(ILogger<OnSchoolUserCreatedHandler> logger) : IPluginEventHandler<CreateSchoolUserCommand>
    {
        public Task HandleAsync(CreateSchoolUserCommand command, CancellationToken cancellationToken = default)
        {
            logger.LogInformation("Example Plugin: SchoolUser '{FirstName} {LastName}' was created!", command.FirstName, command.LastName);
            return Task.CompletedTask;
        }
    }
}
