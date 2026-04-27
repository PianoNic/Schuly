using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class SchoolUser : Base
    {
        public Guid ApplicationUserId { get; set; }
        public ApplicationUser? ApplicationUser { get; set; }

        public Guid SchoolId { get; set; }
        public School? School { get; set; }

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
        public UserState State { get; set; } = UserState.Active;

        public string? StudentNumber { get; set; }
        public string? TeacherCode { get; set; }

        public ICollection<Absence> Absences { get; set; } = [];
        public ICollection<Grade> Grades { get; set; } = [];
        public ICollection<Class> Classes { get; set; } = [];
    }
}
