namespace Schuly.Application.Dtos
{
    public class ApplicationUserDto
    {
        public Guid Id { get; set; }
        public required string ExternalId { get; set; }
        public required string Email { get; set; }
        public string? DisplayName { get; set; }
        public string? ProfilePictureUrl { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public List<SchoolUserSummaryDto> SchoolUsers { get; set; } = new List<SchoolUserSummaryDto>();
    }

    public class SchoolUserSummaryDto
    {
        public Guid Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? Role { get; set; }
    }
}
