namespace Schuly.Domain
{
    public class School : Base
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Website { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? State { get; set; }
        public string? Zip { get; set; }
        public string? Country { get; set; }

        public ICollection<SchoolUser> SchoolUsers { get; set; } = [];
        public ICollection<Class> Classes { get; set; } = [];
    }
}
