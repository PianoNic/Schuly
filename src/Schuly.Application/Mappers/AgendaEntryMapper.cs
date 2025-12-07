using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class AgendaEntryMapper
    {
        public static AgendaEntryDto ToDto(this AgendaEntry agendaEntry)
        {
            return new AgendaEntryDto
            {
                Id = agendaEntry.Id,
                EntryType = agendaEntry.EntryType,
                Title = agendaEntry.Title,
                Description = agendaEntry.Description,
                Place = agendaEntry.Place,
                Date = agendaEntry.Date,
                ClassId = agendaEntry.ClassId
            };
        }

        public static AgendaEntry ToDomain(this AgendaEntryDto dto)
        {
            return new AgendaEntry
            {
                Id = dto.Id,
                EntryType = dto.EntryType,
                Title = dto.Title,
                Description = dto.Description,
                Place = dto.Place,
                Date = dto.Date,
                ClassId = dto.ClassId
            };
        }

        public static List<AgendaEntryDto> ToDto(this List<AgendaEntry> agendaEntries)
        {
            return agendaEntries.Select(a => a.ToDto()).ToList();
        }

        public static List<AgendaEntry> ToDomain(this List<AgendaEntryDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
