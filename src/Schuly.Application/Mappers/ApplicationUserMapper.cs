using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class ApplicationUserMapper
    {
        public static ApplicationUserDto ToDto(this ApplicationUser applicationUser)
        {
            return new ApplicationUserDto
            {
                Id = applicationUser.Id,
                AuthenticationEmail = applicationUser.AuthenticationEmail,
                DisplayName = applicationUser.DisplayName,
                ProfilePictureUrl = applicationUser.ProfilePictureUrl,
                LastLoginAt = applicationUser.LastLoginAt,
                IsEmailVerified = applicationUser.IsEmailVerified,
                IsTwoFactorEnabled = applicationUser.IsTwoFactorEnabled,
                CreatedAt = applicationUser.CreatedAt,
                UpdatedAt = applicationUser.UpdatedAt,
                SchoolUsers = applicationUser.SchoolUsers.Select(su => new SchoolUserSummaryDto
                {
                    Id = su.Id,
                    FirstName = su.FirstName,
                    LastName = su.LastName,
                    Email = su.Email,
                    Role = su.Role.ToString()
                }).ToList()
            };
        }

        public static List<ApplicationUserDto> ToDto(this List<ApplicationUser> applicationUsers)
        {
            return applicationUsers.Select(au => au.ToDto()).ToList();
        }
    }
}
