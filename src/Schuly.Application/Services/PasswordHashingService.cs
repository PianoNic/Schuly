using System.Security.Cryptography;

namespace Schuly.Application.Services
{
    public interface IPasswordHashingService
    {
        (string Hash, string Salt) HashPassword(string password);
        bool VerifyPassword(string password, string hash, string salt);
    }

    public class PasswordHashingService : IPasswordHashingService
    {
        private const int SaltSize = 16;
        private const int HashSize = 20;
        private const int Iterations = 10000;

        public (string Hash, string Salt) HashPassword(string password)
        {
            byte[] saltBytes = RandomNumberGenerator.GetBytes(SaltSize);

            using var pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, Iterations, HashAlgorithmName.SHA256);
            byte[] hashBytes = pbkdf2.GetBytes(HashSize);

            return (Convert.ToBase64String(hashBytes), Convert.ToBase64String(saltBytes));
        }

        public bool VerifyPassword(string password, string hash, string salt)
        {
            try
            {
                byte[] saltBytes = Convert.FromBase64String(salt);
                byte[] hashBytes = Convert.FromBase64String(hash);

                using var pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, Iterations, HashAlgorithmName.SHA256);
                byte[] computedHash = pbkdf2.GetBytes(HashSize);

                return CryptographicOperations.FixedTimeEquals(hashBytes, computedHash);
            }
            catch
            {
                return false;
            }
        }
    }
}
