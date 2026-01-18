using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class SchoolUserMapper
    {
        public static SchoolUserDto ToDto(this SchoolUser schoolUser)
        {
            return new SchoolUserDto
            {
                Id = schoolUser.Id,
                ApplicationUserId = schoolUser.ApplicationUserId,
                SchoolId = schoolUser.SchoolId,
                SchoolName = schoolUser.School?.Name,
                FirstName = schoolUser.FirstName,
                LastName = schoolUser.LastName,
                Email = schoolUser.Email,
                PrivateEmail = schoolUser.PrivateEmail,
                PhoneNumber = schoolUser.PhoneNumber,
                Street = schoolUser.Street,
                City = schoolUser.City,
                Zip = schoolUser.Zip,
                Birthday = schoolUser.Birthday,
                EntryDate = schoolUser.EntryDate,
                LeaveDate = schoolUser.LeaveDate,
                Role = schoolUser.Role,
                State = schoolUser.State,
                StudentNumber = schoolUser.StudentNumber,
                TeacherCode = schoolUser.TeacherCode,
                CreatedAt = schoolUser.CreatedAt,
                UpdatedAt = schoolUser.UpdatedAt,
                Absences = schoolUser.Absences.Select(a => a.ToDto()).ToList(),
                Grades = schoolUser.Grades.Select(g => g.ToDto()).ToList(),
                Classes = schoolUser.Classes.Select(c => new UserClassDto
                {
                    ClassId = c.Id,
                    ClassName = c.Name
                }).ToList()
            };
        }

        public static List<SchoolUserDto> ToDto(this List<SchoolUser> schoolUsers)
        {
            return schoolUsers.Select(su => su.ToDto()).ToList();
        }
    }
}
