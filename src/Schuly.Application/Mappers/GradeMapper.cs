using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class GradeMapper
    {
        public static GradeDto ToDto(this Grade grade)
        {
            return new GradeDto
            {
                Id = grade.Id,
                Score = grade.Score,
                Weighting = grade.Weighting,
                ExamId = grade.ExamId,
                SchoolUserId = grade.SchoolUserId
            };
        }

        public static Grade ToDomain(this GradeDto dto)
        {
            return new Grade
            {
                Id = dto.Id,
                Score = dto.Score,
                Weighting = dto.Weighting,
                ExamId = dto.ExamId,
                SchoolUserId = dto.SchoolUserId
            };
        }

        public static List<GradeDto> ToDto(this List<Grade> grades)
        {
            return grades.Select(g => g.ToDto()).ToList();
        }

        public static List<Grade> ToDomain(this List<GradeDto> dtos)
        {
            return dtos.Select(d => d.ToDomain()).ToList();
        }
    }
}
