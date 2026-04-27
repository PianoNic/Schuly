using Mediator;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Configuration;
using Schuly.Application.Queries.User;
using Schuly.Application.Services;
using Schuly.Application.Services.Interfaces;
using Schuly.Infrastructure;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers()
    .AddJsonOptions(options =>
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()));

builder.Services.AddMediator(options => { options.ServiceLifetime = ServiceLifetime.Scoped; });

builder.Services.AddSingleton<IJwtConfigurationFactory, JwtConfigurationFactory>();

var jwtFactory = builder.Services.BuildServiceProvider().GetRequiredService<IJwtConfigurationFactory>();
var jwtSettings = jwtFactory.LoadJwtSettings();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options => jwtFactory.ConfigureJwtBearerOptions(options));

builder.Services.AddAuthorization();

builder.Services.AddScoped<IPasswordHashingService, PasswordHashingService>();
builder.Services.AddScoped<ITokenGenerationService>(sp =>
    new TokenGenerationService(jwtSettings.SecretKey, jwtSettings.Issuer, jwtSettings.Audience, jwtSettings.ExpirationMinutes));
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IAuthorizationService, AuthorizationService>();

builder.Services.AddOpenApi();

builder.Services.AddDbContext<SchulyDbContext>(options =>
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("SchulyDatabase"),
        npgsqlOptions => npgsqlOptions
        .EnableRetryOnFailure(
            maxRetryCount: 5,
            maxRetryDelay: TimeSpan.FromSeconds(10),
            errorCodesToAdd: null
        )
    ));

var app = builder.Build();

using var scope = app.Services.CreateScope();
scope.ServiceProvider.GetRequiredService<SchulyDbContext>().Database.Migrate();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "Schuly API v1");
    });
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
