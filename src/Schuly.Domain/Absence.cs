using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class Absence
    {
        public long Id { get; set; }
        public required string Reason { get; set; } = "Absent";
        public required AbsenceType Type { get; set; }
        public required DateTime From { get; set; }
        public required DateTime Until { get; set; }
    }
}
