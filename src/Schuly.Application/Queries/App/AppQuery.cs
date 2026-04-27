using Mediator;
using Microsoft.Extensions.Configuration;
using Schuly.Application.Dtos;
using Schuly.Application.Models;

namespace Schuly.Application.Queries.App
{
    public record AppQuery() : IQuery<Result<AppDto>>;

    public class AppQueryHandler(IConfiguration configuration) : IQueryHandler<AppQuery, Result<AppDto>>
    {
        public async ValueTask<Result<AppDto>> Handle(AppQuery query, CancellationToken cancellationToken)
        {
            return Result<AppDto>.Success(new AppDto(
                configuration["Oidc:Authority"] ?? string.Empty,
                configuration["Oidc:ClientId"] ?? string.Empty,
                configuration["Oidc:RedirectUri"] ?? "http://localhost:4200/callback",
                configuration["Oidc:PostLogoutRedirectUri"] ?? "http://localhost:4200/",
                configuration["Oidc:Scope"] ?? "openid profile email groups picture",
                "1.0.0"
            ));
        }
    }
}
