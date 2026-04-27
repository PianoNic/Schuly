using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using Schuly.Infrastructure.Dtos;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text.Json;

namespace Schuly.Infrastructure.Services
{
    public class OidcService(IHttpContextAccessor httpContextAccessor, IHttpClientFactory httpClientFactory, IOptionsMonitor<JwtBearerOptions> jwtOptionsMonitor) : IOidcService
    {
        public async Task<OidcUser?> GetCurrentUserAsync(CancellationToken cancellationToken = default)
        {
            var identity = httpContextAccessor.HttpContext?.User.Identity as ClaimsIdentity;
            if (identity is null || !identity.IsAuthenticated)
                return null;

            var externalId = identity.FindFirst("sub")?.Value
                ?? identity.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(externalId))
                return null;

            var userInfo = await FetchUserInfoAsync(cancellationToken);

            return new OidcUser(
                externalId,
                GetValue(userInfo, "email") ?? identity.FindFirst(ClaimTypes.Email)?.Value,
                GetValue(userInfo, "name") ?? identity.FindFirst(ClaimTypes.Name)?.Value,
                GetValue(userInfo, "picture") ?? identity.FindFirst("picture")?.Value,
                GetArray(userInfo, "groups") ?? identity.FindAll("groups").Select(c => c.Value).ToList());
        }

        private async Task<JsonElement?> FetchUserInfoAsync(CancellationToken cancellationToken)
        {
            var options = jwtOptionsMonitor.Get(JwtBearerDefaults.AuthenticationScheme);
            var config = await options.ConfigurationManager!.GetConfigurationAsync(cancellationToken);
            if (string.IsNullOrEmpty(config.UserInfoEndpoint)) return null;

            var context = httpContextAccessor.HttpContext;
            if (context is null) return null;

            if (!AuthenticationHeaderValue.TryParse(context.Request.Headers.Authorization, out var auth)
                || !string.Equals(auth.Scheme, "Bearer", StringComparison.OrdinalIgnoreCase)
                || string.IsNullOrEmpty(auth.Parameter))
                return null;

            using var request = new HttpRequestMessage(HttpMethod.Get, config.UserInfoEndpoint);
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", auth.Parameter);

            using var response = await httpClientFactory.CreateClient().SendAsync(request, cancellationToken);
            if (!response.IsSuccessStatusCode) return null;

            using var doc = await JsonDocument.ParseAsync(await response.Content.ReadAsStreamAsync(cancellationToken), cancellationToken: cancellationToken);
            return doc.RootElement.Clone();
        }

        private static string? GetValue(JsonElement? element, string property) =>
            element?.TryGetProperty(property, out var value) == true && value.ValueKind == JsonValueKind.String
                ? value.GetString()
                : null;

        private static List<string>? GetArray(JsonElement? element, string property) =>
            element?.TryGetProperty(property, out var value) == true && value.ValueKind == JsonValueKind.Array
                ? value.EnumerateArray().Where(x => x.ValueKind == JsonValueKind.String).Select(x => x.GetString()!).ToList()
                : null;
    }
}
