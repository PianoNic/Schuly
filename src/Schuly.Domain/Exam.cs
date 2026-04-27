using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class Exam : Base
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public ExamType Type { get; set; }
        public Guid ClassId { get; set; }
        public Class? Class { get; set; }
        public ICollection<Grade> Grades { get; set; } = [];
    }
}
