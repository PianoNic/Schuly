using Schuly.Domain.Enums;

namespace Schuly.Domain
{
    public class UserClass
    {
        public long UserId { get; set; }
        public long ClassId { get; set; }
        public DateTime JoinedDate { get; set; } = DateTime.UtcNow;
        
        public required User User { get; set; }
        public required Class Class { get; set; }
    }
}
