using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace Schuly.Application.Configuration
{
    public interface IJwtConfigurationFactory
    {
        JwtSettings LoadJwtSettings();
        TokenValidationParameters CreateTokenValidationParameters();
        void ConfigureJwtBearerOptions(JwtBearerOptions options);
    }

    public class JwtConfigurationFactory : IJwtConfigurationFactory
    {
        private readonly IConfiguration _configuration;
        private JwtSettings? _cachedSettings;

        public JwtConfigurationFactory(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public JwtSettings LoadJwtSettings()
        {
            if (_cachedSettings != null)
                return _cachedSettings;

            var jwtSection = _configuration.GetSection("Jwt");

            var secretKey = jwtSection["SecretKey"] ?? throw new InvalidOperationException(
                "JWT SecretKey is missing in appsettings.json. Please configure Jwt:SecretKey.");

            var issuer = jwtSection["Issuer"] ?? throw new InvalidOperationException(
                "JWT Issuer is missing in appsettings.json. Please configure Jwt:Issuer.");

            var audience = jwtSection["Audience"] ?? throw new InvalidOperationException(
                "JWT Audience is missing in appsettings.json. Please configure Jwt:Audience.");

            var expirationMinutesStr = jwtSection["ExpirationMinutes"] ?? "60";
            if (!int.TryParse(expirationMinutesStr, out var expirationMinutes))
            {
                throw new InvalidOperationException(
                    $"JWT ExpirationMinutes must be a valid integer. Got: {expirationMinutesStr}");
            }

            if (expirationMinutes <= 0)
            {
                throw new InvalidOperationException(
                    $"JWT ExpirationMinutes must be greater than 0. Got: {expirationMinutes}");
            }

            // Validate secret key strength (minimum 32 characters for HS256)
            if (secretKey.Length < 32)
            {
                throw new InvalidOperationException(
                    $"JWT SecretKey must be at least 32 characters long for security. Current length: {secretKey.Length}");
            }

            _cachedSettings = new JwtSettings
            {
                SecretKey = secretKey,
                Issuer = issuer,
                Audience = audience,
                ExpirationMinutes = expirationMinutes
            };

            return _cachedSettings;
        }

        public TokenValidationParameters CreateTokenValidationParameters()
        {
            var settings = LoadJwtSettings();
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(settings.SecretKey));

            return new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = key,
                ValidateIssuer = true,
                ValidIssuer = settings.Issuer,
                ValidateAudience = true,
                ValidAudience = settings.Audience,
                ValidateLifetime = true,
                ClockSkew = TimeSpan.Zero
            };
        }

        public void ConfigureJwtBearerOptions(JwtBearerOptions options)
        {
            options.TokenValidationParameters = CreateTokenValidationParameters();
        }
    }
}
