namespace Schuly.Application.Dtos
{
    public class ClassDto
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public Guid SchoolId { get; set; }
        public string? SchoolName { get; set; }
        public List<SchoolUserDto> Students { get; set; } = new List<SchoolUserDto>();
        public List<AgendaEntryDto> Agenda { get; set; } = new List<AgendaEntryDto>();
        public List<ExamDto> Exams { get; set; } = new List<ExamDto>();
    }
}
