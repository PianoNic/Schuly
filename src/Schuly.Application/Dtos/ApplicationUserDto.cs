namespace Schuly.Application.Dtos
{
    public class ApplicationUserDto
    {
        public Guid Id { get; set; }
        public string? AuthenticationEmail { get; set; }
        public string? DisplayName { get; set; }
        public string? ProfilePictureUrl { get; set; }
        public DateTime? LastLoginAt { get; set; }
        public bool IsEmailVerified { get; set; }
        public bool IsTwoFactorEnabled { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public List<SchoolUserSummaryDto> SchoolUsers { get; set; } = new List<SchoolUserSummaryDto>();
    }

    public class SchoolUserSummaryDto
    {
        public long Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? Role { get; set; }
    }
}
