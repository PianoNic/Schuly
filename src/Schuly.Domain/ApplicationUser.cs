namespace Schuly.Domain
{
    public class ApplicationUser : Base
    {
        public required string ExternalId { get; set; }
        public required string Email { get; set; }
        public string DisplayName { get; set; } = "Schuly User";
        public string? ProfilePictureUrl { get; set; }
        public ICollection<SchoolUser> SchoolUsers { get; set; } = [];
    }
}
