namespace Schuly.Domain
{
    public class ApplicationUser : AuthenticationCredentials
    {
        public new Guid Id { get; set; }
        public string? DisplayName { get; set; }
        public string? ProfilePictureUrl { get; set; }
        public DateTime? LastLoginAt { get; set; }
        public bool IsEmailVerified { get; set; } = false;
        public bool IsTwoFactorEnabled { get; set; } = false;
        public ICollection<SchoolUser> SchoolUsers { get; set; } = new List<SchoolUser>();
    }
}
