namespace Schuly.Domain
{
    public class Class : Base
    {
        public required string Name { get; set; }
        public string? Description { get; set; }

        
        public ICollection<UserClass> UserClasses { get; set; } = new List<UserClass>();
        public ICollection<Exam> Exams { get; set; } = new List<Exam>();
        public ICollection<AgendaEntry> AgendaEntries { get; set; } = new List<AgendaEntry>();
    }
}
