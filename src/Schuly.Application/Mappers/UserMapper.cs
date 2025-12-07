using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class UserMapper
    {
        public static UserDto ToDto(this User user)
        {
            return new UserDto
            {
                Id = user.Id,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                PrivateEmail = user.PrivateEmail,
                PhoneNumber = user.PhoneNumber,
                Street = user.Street,
                City = user.City,
                Zip = user.Zip,
                Birthday = user.Birthday,
                EntryDate = user.EntryDate,
                LeaveDate = user.LeaveDate,
                Role = user.Role,
                Absences = user.Absences.Select(a => a.ToDto()).ToList(),
                Grades = user.Grades.Select(g => g.ToDto()).ToList()
            };
        }

        public static User ToDomain(this UserDto dto)
        {
            return new User
            {
                Id = dto.Id,
                FirstName = dto.FirstName,
                LastName = dto.LastName,
                Email = dto.Email,
                PrivateEmail = dto.PrivateEmail,
                PhoneNumber = dto.PhoneNumber,
                Street = dto.Street,
                City = dto.City,
                Zip = dto.Zip,
                Birthday = dto.Birthday,
                EntryDate = dto.EntryDate,
                LeaveDate = dto.LeaveDate,
                Role = dto.Role,
                Absences = dto.Absences.Select(a => a.ToDomain()).ToList(),
                Grades = dto.Grades.Select(g => g.ToDomain()).ToList()
            };
        }

        public static List<UserDto> ToDto(this List<User> users)
        {
            return users.Select(u => u.ToDto()).ToList();
        }

        public static List<User> ToDomain(this List<UserDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
