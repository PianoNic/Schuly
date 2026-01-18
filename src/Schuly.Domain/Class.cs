namespace Schuly.Domain
{
    public class Class : Base
    {
        public new Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public long SchoolId { get; set; }
        public School? School { get; set; }
        public ICollection<User> Students { get; set; } = new List<User>();
        public ICollection<AgendaEntry> Agenda { get; set; } = new List<AgendaEntry>();
        public ICollection<Exam> Exams { get; set; } = new List<Exam>();
    }
}
