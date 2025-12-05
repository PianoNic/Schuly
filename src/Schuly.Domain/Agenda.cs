using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class Agenda
    {
        public long Id { get; set; }
        public required List<AgendaEntry> AgendaEntries { get; set; } = new List<AgendaEntry>();
        public required List<Class> Classes { get; set; } = new List<Class>();
    }
}
