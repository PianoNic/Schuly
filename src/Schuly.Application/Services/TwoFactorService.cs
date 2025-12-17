using Microsoft.Extensions.Caching.Memory;
using OtpNet;
using QRCoder;
using Schuly.Application.Services.Interfaces;
using System.Net;

namespace Schuly.Application.Services
{
    public class TwoFactorService : ITwoFactorService
    {
        private readonly IMemoryCache _memoryCache;
        private const int MaxAttempts = 5;
        private readonly TimeSpan _rateLimitWindow = TimeSpan.FromMinutes(15);

        public TwoFactorService(IMemoryCache memoryCache)
        {
            _memoryCache = memoryCache;
        }

        public string GenerateTotpSecret()
        {
            var secret = KeyGeneration.GenerateRandomKey(20);
            return Base32Encoding.ToString(secret);
        }

        public string GenerateQrCodeUri(string email, string secret, string issuer = "Schuly")
        {
            var encodedEmail = WebUtility.UrlEncode(email);
            var encodedIssuer = WebUtility.UrlEncode(issuer);
            return $"otpauth://totp/{encodedIssuer}:{encodedEmail}?secret={secret}&issuer={encodedIssuer}";
        }

        public bool ValidateTotpCode(string secret, string code, int window = 1)
        {
            try
            {
                var bytes = Base32Encoding.ToBytes(secret);
                var totp = new Totp(bytes);
                return totp.VerifyTotp(code, out long _);
            }
            catch
            {
                return false;
            }
        }

        public bool IsRateLimited(Guid userId)
        {
            var key = $"2fa-attempts:{userId}";
            return _memoryCache.TryGetValue(key, out var attempts) && (int)attempts >= MaxAttempts;
        }

        public void RecordFailedAttempt(Guid userId)
        {
            var key = $"2fa-attempts:{userId}";
            if (_memoryCache.TryGetValue(key, out var attempts))
            {
                _memoryCache.Set(key, (int)attempts + 1, _rateLimitWindow);
            }
            else
            {
                _memoryCache.Set(key, 1, _rateLimitWindow);
            }
        }

        public void ResetAttempts(Guid userId)
        {
            var key = $"2fa-attempts:{userId}";
            _memoryCache.Remove(key);
        }

        public byte[] GenerateQrCodePng(string qrCodeUri)
        {
            using (var qrGenerator = new QRCodeGenerator())
            {
                var qrCodeData = qrGenerator.CreateQrCode(qrCodeUri, QRCodeGenerator.ECCLevel.Q);
                var qrCode = new PngByteQRCode(qrCodeData);
                return qrCode.GetGraphic(10);
            }
        }
    }
}
