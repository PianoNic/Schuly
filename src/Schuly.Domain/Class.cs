namespace Schuly.Domain
{
    public class Class : Base
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public Guid SchoolId { get; set; }
        public School? School { get; set; }
        public ICollection<SchoolUser> Students { get; set; } = [];
        public ICollection<AgendaEntry> Agenda { get; set; } = [];
        public ICollection<Exam> Exams { get; set; } = [];
    }
}
