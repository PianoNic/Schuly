using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    /// <summary>
    /// User entity representing a student, teacher, or administrator in the system.
    /// Inherits authentication credentials from AuthenticationCredentials base class.
    /// </summary>
    public class User : AuthenticationCredentials
    {
        public new Guid Id { get; set; }

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

        public ICollection<Absence> Absences { get; set; } = new List<Absence>();
        public ICollection<Grade> Grades { get; set; } = new List<Grade>();
        public ICollection<Class> Classes { get; set; } = new List<Class>();
    }
}
