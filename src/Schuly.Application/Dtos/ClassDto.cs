namespace Schuly.Application.Dtos
{
    public class ClassDto
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public List<UserDto> Students { get; set; } = new List<UserDto>();
        public List<AgendaEntryDto> Agenda { get; set; } = new List<AgendaEntryDto>();
        public List<ExamDto> Exams { get; set; } = new List<ExamDto>();
    }
}
