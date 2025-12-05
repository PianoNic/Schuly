namespace Schuly.Domain
{
    public class User
    {
        public Guid Id { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public string Email { get; set; }
        public string? PrivateEmail { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? Zip { get; set; }
        public required DateOnly Birthday { get; set; }
        public required DateOnly EntryDate { get; set; }
        public DateOnly? LeaveDate { get; set; }
        public List<Absence> Absences { get; set; } = new List<Absence>();
        public List<Class> Classes { get; set; } = new List<Class>();
        public List<Class> ClassesInCharge { get; set; } = new List<Class>();
        public List<Grade> Grades { get; set; } = new List<Grade>();
        public List<Exam> Exams { get; set; } = new List<Exam>();
    }
}
