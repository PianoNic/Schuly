using Schuly.Application.Dtos;
using Schuly.Domain;

namespace Schuly.Application.Mappers
{
    public static class SchoolMapper
    {
        public static SchoolDto ToDto(this School school)
        {
            return new SchoolDto
            {
                Id = school.Id,
                Name = school.Name,
                Description = school.Description,
                Email = school.Email,
                PhoneNumber = school.PhoneNumber,
                Website = school.Website,
                Street = school.Street,
                City = school.City,
                State = school.State,
                Zip = school.Zip,
                Country = school.Country,
                CreatedAt = school.CreatedAt,
                UpdatedAt = school.UpdatedAt
            };
        }

        public static List<SchoolDto> ToDto(this List<School> schools)
        {
            return schools.Select(s => s.ToDto()).ToList();
        }
    }
}
