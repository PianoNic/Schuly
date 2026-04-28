using Schuly.Plugin.Abstractions;
using Schuly.Plugin.Example;

namespace Schuly.Tests;

public class PluginSystemTests
{
    [Test]
    public async Task ExamplePlugin_ImplementsInterface()
    {
        var plugin = new ExamplePlugin();

        await Assert.That(plugin).IsAssignableTo<ISchulyPlugin>();
        await Assert.That(plugin.Name).IsEqualTo("Example Plugin");
        await Assert.That(plugin.Version).IsEqualTo("1.0.0");
    }

    [Test]
    public async Task ExamplePlugin_ConfigureServices_DoesNotThrow()
    {
        var plugin = new ExamplePlugin();
        var services = new Microsoft.Extensions.DependencyInjection.ServiceCollection();

        var context = new PluginServiceContext("Host=localhost;Database=test", new Microsoft.Extensions.Configuration.ConfigurationBuilder().Build());
        plugin.ConfigureServices(services, context);

        await Assert.That(services.Count).IsGreaterThan(0);
    }

    [Test]
    public async Task OnSchoolUserCreatedHandler_ImplementsEventHandler()
    {
        var handlerType = typeof(OnSchoolUserCreatedHandler);
        var interfaceType = typeof(IPluginEventHandler<Schuly.Application.Commands.SchoolUser.CreateSchoolUserCommand>);

        await Assert.That(interfaceType.IsAssignableFrom(handlerType)).IsTrue();
    }
}
