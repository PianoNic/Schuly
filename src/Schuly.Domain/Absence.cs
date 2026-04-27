using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class Absence : Base
    {
        public required string Reason { get; set; } = "Absent";
        public required AbsenceType Type { get; set; }
        public required DateTime From { get; set; }
        public required DateTime Until { get; set; }
        public Guid SchoolUserId { get; set; }
        public SchoolUser? SchoolUser { get; set; }
    }
}
