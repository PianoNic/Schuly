using Mediator;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Configuration;
using Schuly.Application.Queries.User;
using Schuly.Application.Services;
using Schuly.Application.Services.Interfaces;
using Schuly.Infrastructure;
using System.Text.Json.Serialization;

[assembly: MediatorOptions(ServiceLifetime = ServiceLifetime.Scoped)]

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
    });

builder.Services.AddMediator((MediatorOptions options) =>
{
    options.Assemblies = [typeof(GetUserQuery)];
    options.ServiceLifetime = ServiceLifetime.Scoped;
});

// Register JWT configuration factory
builder.Services.AddSingleton<IJwtConfigurationFactory, JwtConfigurationFactory>();

// Load JWT settings and validate
var jwtFactory = builder.Services.BuildServiceProvider().GetRequiredService<IJwtConfigurationFactory>();
var jwtSettings = jwtFactory.LoadJwtSettings();

// Add authentication services with JWT configuration
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options => jwtFactory.ConfigureJwtBearerOptions(options));

builder.Services.AddAuthorization();

// Register application services
builder.Services.AddScoped<IPasswordHashingService, PasswordHashingService>();
builder.Services.AddScoped<ITokenGenerationService>(sp =>
    new TokenGenerationService(jwtSettings.SecretKey, jwtSettings.Issuer, jwtSettings.Audience, jwtSettings.ExpirationMinutes));
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<ITwoFactorService, TwoFactorService>();
builder.Services.AddMemoryCache();

// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

// Configure the DbContext
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

// Applying database migrations
using var scope = app.Services.CreateScope();
scope.ServiceProvider.GetRequiredService<SchulyDbContext>().Database.Migrate();

// Configure the HTTP request pipeline.
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
