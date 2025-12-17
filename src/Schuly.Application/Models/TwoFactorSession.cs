namespace Schuly.Application.Models
{
    public class TwoFactorSession
    {
        public Guid UserId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime ExpiresAt { get; set; }
        public string Email { get; set; }

        public TwoFactorSession(Guid userId, string email, TimeSpan expirationDuration)
        {
            UserId = userId;
            Email = email;
            CreatedAt = DateTime.UtcNow;
            ExpiresAt = CreatedAt.Add(expirationDuration);
        }

        public bool IsExpired => DateTime.UtcNow > ExpiresAt;
    }
}
