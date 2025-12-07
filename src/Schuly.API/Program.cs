using Mediator;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;
using Schuly.Application.Queries;
using Schuly.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

builder.Services.AddMediator((MediatorOptions options) =>
{
    options.Assemblies = [typeof(GetUserInfoQuery)];
});

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
    app.MapScalarApiReference();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
