using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class AbsenceMapper
    {
        public static AbsenceDto ToDto(this Absence absence)
        {
            return new AbsenceDto
            {
                Id = absence.Id,
                Reason = absence.Reason,
                Type = absence.Type,
                From = absence.From,
                Until = absence.Until,
                UserId = absence.UserId
            };
        }

        public static Absence ToDomain(this AbsenceDto dto)
        {
            return new Absence
            {
                Id = dto.Id,
                Reason = dto.Reason,
                Type = dto.Type,
                From = dto.From,
                Until = dto.Until,
                UserId = dto.UserId
            };
        }

        public static List<AbsenceDto> ToDto(this List<Absence> absences)
        {
            return absences.Select(a => a.ToDto()).ToList();
        }

        public static List<Absence> ToDomain(this List<AbsenceDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
