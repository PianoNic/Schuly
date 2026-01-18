using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class ClassMapper
    {
        public static ClassDto ToDto(this Class classEntity)
        {
            return new ClassDto
            {
                Id = classEntity.Id,
                Name = classEntity.Name,
                Description = classEntity.Description,
                SchoolId = classEntity.SchoolId,
                SchoolName = classEntity.School?.Name,
                Students = classEntity.Students.Select(s => s.ToDto()).ToList(),
                Agenda = classEntity.Agenda.Select(a => a.ToDto()).ToList(),
                Exams = classEntity.Exams.Select(e => e.ToDto()).ToList()
            };
        }

        public static Class ToDomain(this ClassDto dto)
        {
            return new Class
            {
                Id = dto.Id,
                Name = dto.Name,
                Description = dto.Description,
                SchoolId = dto.SchoolId,
                Students = dto.Students.Select(s => s.ToDomain()).ToList(),
                Agenda = dto.Agenda.Select(a => a.ToDomain()).ToList(),
                Exams = dto.Exams.Select(e => e.ToDomain()).ToList()
            };
        }

        public static List<ClassDto> ToDto(this List<Class> classes)
        {
            return classes.Select(c => c.ToDto()).ToList();
        }

        public static List<Class> ToDomain(this List<ClassDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
