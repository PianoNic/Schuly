namespace Schuly.Domain
{
    public abstract class AuthenticationCredentials : Base
    {
        public string? AuthenticationEmail { get; set; }
        public string? PasswordHash { get; set; }
        public string? PasswordSalt { get; set; }
        public DateTime? PasswordChangedAt { get; set; }
        public bool IsAuthenticationEmailVerified { get; set; } = false;

        public bool TwoFactorEnabled { get; set; } = false;
        public string? TwoFactorSecret { get; set; }
        public DateTime? TwoFactorEnabledAt { get; set; }
    }
}
