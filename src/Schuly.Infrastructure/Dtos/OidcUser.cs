namespace Schuly.Infrastructure.Dtos;

public record OidcUser(
    string ExternalId,
    string? Email,
    string? DisplayName,
    string? AvatarUrl,
    IReadOnlyList<string> Roles);
