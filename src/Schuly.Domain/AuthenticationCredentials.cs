namespace Schuly.Domain
{
    public abstract class AuthenticationCredentials : Base
    {
        public string? AuthenticationEmail { get; set; }
        public string? PasswordHash { get; set; }
        public string? PasswordSalt { get; set; }
        public DateTime? PasswordChangedAt { get; set; }
        public bool IsAuthenticationEmailVerified { get; set; } = false;
    }
}
