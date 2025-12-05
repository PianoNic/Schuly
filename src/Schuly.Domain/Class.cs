namespace Schuly.Domain
{
    public class Class
    {
        public long Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public List<User> Students { get; set; } = new List<User>();
        public List<User> PersonsInCharge { get; set; } = new List<User>();
        public List<Exam> Exams { get; set; } = new List<Exam>();
        public List<ExamAverage> ExamAverages { get; set; } = new List<ExamAverage>();
        public required Agenda Agenda { get; set; }
    }
}
