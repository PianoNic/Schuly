using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class ExamMapper
    {
        public static ExamDto ToDto(this Exam exam)
        {
            return new ExamDto
            {
                Id = exam.Id,
                Name = exam.Name,
                Description = exam.Description,
                Type = exam.Type,
                ClassAverage = exam.Grades.Any() ? exam.Grades.Sum(g => g.Score) / exam.Grades.Count : 0,
                ClassId = exam.ClassId,
                Grades = exam.Grades.Select(g => g.ToDto()).ToList()
            };
        }

        public static Exam ToDomain(this ExamDto dto)
        {
            return new Exam
            {
                Id = dto.Id,
                Name = dto.Name,
                Description = dto.Description,
                Type = dto.Type,
                ClassId = dto.ClassId,
                Grades = dto.Grades.Select(g => g.ToDomain()).ToList()
            };
        }

        public static List<ExamDto> ToDto(this List<Exam> exams)
        {
            return exams.Select(e => e.ToDto()).ToList();
        }

        public static List<Exam> ToDomain(this List<ExamDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
