using System.Security.Cryptography;
using System.Text;

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
            using (var rng = new RNGCryptoServiceProvider())
            {
                byte[] saltBytes = new byte[SaltSize];
                rng.GetBytes(saltBytes);

                using (var pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, Iterations, HashAlgorithmName.SHA256))
                {
                    byte[] hashBytes = pbkdf2.GetBytes(HashSize);

                    string salt = Convert.ToBase64String(saltBytes);
                    string hash = Convert.ToBase64String(hashBytes);

                    return (hash, salt);
                }
            }
        }

        public bool VerifyPassword(string password, string hash, string salt)
        {
            try
            {
                byte[] saltBytes = Convert.FromBase64String(salt);
                byte[] hashBytes = Convert.FromBase64String(hash);

                using (var pbkdf2 = new Rfc2898DeriveBytes(password, saltBytes, Iterations, HashAlgorithmName.SHA256))
                {
                    byte[] computedHash = pbkdf2.GetBytes(HashSize);

                    for (int i = 0; i < HashSize; i++)
                    {
                        if (hashBytes[i] != computedHash[i])
                        {
                            return false;
                        }
                    }

                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
