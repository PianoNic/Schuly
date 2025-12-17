namespace Schuly.Application.Services.Interfaces
{
    public interface ITwoFactorService
    {
        string GenerateTotpSecret();
        string GenerateQrCodeUri(string email, string secret, string issuer = "Schuly");
        bool ValidateTotpCode(string secret, string code, int window = 1);
        bool IsRateLimited(Guid userId);
        void RecordFailedAttempt(Guid userId);
        void ResetAttempts(Guid userId);
        byte[] GenerateQrCodePng(string qrCodeUri);
    }
}
