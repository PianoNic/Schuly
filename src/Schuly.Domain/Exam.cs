using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class Exam
    {
        public long Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public ExamType Type { get; set; }
        public List<Grade> Grades { get; set; } = new List<Grade>();
        public List<User> Users { get; set; } = new List<User>();
        public List<Class> Classes { get; set; } = new List<Class>();
        public List<ExamAverage> ExamAverages { get; set; } = new List<ExamAverage>();
    }
}
