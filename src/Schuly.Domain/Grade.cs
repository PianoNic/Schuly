namespace Schuly.Domain
{
    public class Grade : Base
    {
        public decimal Score { get; set; }
        public decimal Weighting { get; set; }
        public required DateTime RegisteredDate { get; set; } = DateTime.UtcNow;

        public long ExamId { get; set; }
        public Exam Exam { get; set; }
        public long UserId { get; set; }
        public User User { get; set; }
    }
}
