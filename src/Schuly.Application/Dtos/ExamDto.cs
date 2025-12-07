using Schuly.Domain.Enums;

namespace Schuly.Application.Dtos
{
    public class ExamDto
    {
        public long Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public ExamType Type { get; set; }
        public required decimal ClassAverage { get; set; }
        public Guid ClassId { get; set; }
        public List<GradeDto> Grades { get; set; } = new List<GradeDto>();
    }
}
