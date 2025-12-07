using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class AgendaEntry : Base
    {
        public required AgendaEntryType EntryType { get; set; }
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? Place { get; set; }
        public required DateTime Date { get; set; }

        public long ClassId { get; set; }
        public Class? Class { get; set; }
    }
}
