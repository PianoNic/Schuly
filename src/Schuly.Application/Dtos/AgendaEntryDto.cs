using Schuly.Domain.Enums;

namespace Schuly.Application.Dtos
{
    public class AgendaEntryDto
    {
        public long Id { get; set; }
        public required AgendaEntryType EntryType { get; set; }
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? Place { get; set; }
        public required DateTime Date { get; set; }
        public Guid ClassId { get; set; }
    }
}
