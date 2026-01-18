using Schuly.Domain.Enums;

namespace Schuly.Application.Dtos
{
    public class SchoolUserDto
    {
        public long Id { get; set; }
        public Guid ApplicationUserId { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public string? PrivateEmail { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? Zip { get; set; }
        public required DateOnly Birthday { get; set; }
        public required DateOnly EntryDate { get; set; }
        public DateOnly? LeaveDate { get; set; }
        public required Roles Role { get; set; }
        public UserState State { get; set; }
        public string? StudentNumber { get; set; }
        public string? TeacherCode { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public List<AbsenceDto> Absences { get; set; } = new List<AbsenceDto>();
        public List<GradeDto> Grades { get; set; } = new List<GradeDto>();
        public List<UserClassDto> Classes { get; set; } = new List<UserClassDto>();
    }
}
