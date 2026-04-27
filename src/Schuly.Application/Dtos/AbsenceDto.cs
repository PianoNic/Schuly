using Schuly.Domain.Enums;

namespace Schuly.Application.Dtos
{
    public class AbsenceDto
    {
        public Guid Id { get; set; }
        public required string Reason { get; set; }
        public required AbsenceType Type { get; set; }
        public required DateTime From { get; set; }
        public required DateTime Until { get; set; }
        public Guid SchoolUserId { get; set; }
    }
}
