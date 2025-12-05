using Schuly.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class AgendaEntry
    {
        public long Id { get; set; }
        public required AgendaEntryType EntryType { get; set; }
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? Place { get; set; }
        public required DateTime Date { get; set; }
        public required List<Agenda> Agendas { get; set; }
    }
}
