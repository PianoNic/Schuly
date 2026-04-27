using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Schuly.Infrastructure.Services;
using System.Security.Claims;

namespace Schuly.API.Extensions
{
    public static class AuthenticationExtensions
    {
        public static AuthenticationBuilder AddUserSync(this AuthenticationBuilder builder)
        {
            builder.Services.PostConfigure<JwtBearerOptions>(
                JwtBearerDefaults.AuthenticationScheme,
                options =>
                {
                    options.Events ??= new JwtBearerEvents();
                    var previous = options.Events.OnTokenValidated;

                    options.Events.OnTokenValidated = async context =>
                    {
                        if (previous is not null)
                            await previous(context);

                        if (context.Principal?.Identity is not ClaimsIdentity identity)
                            return;

                        context.HttpContext.User = context.Principal;

                        var externalId = identity.FindFirst("sub")?.Value ?? identity.FindFirst(ClaimTypes.NameIdentifier)?.Value;

                        if (string.IsNullOrEmpty(externalId))
                            return;

                        var userService = context.HttpContext.RequestServices.GetRequiredService<IUserService>();

                        if (await userService.ExistsAsync(externalId, context.HttpContext.RequestAborted))
                            return;

                        await userService.SyncCurrentUserAsync(context.HttpContext.RequestAborted);
                    };
                });

            return builder;
        }
    }
}
