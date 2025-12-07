namespace Schuly.Application.Dtos
{
    public class GradeDto
    {
        public long Id { get; set; }
        public decimal Score { get; set; }
        public decimal Weighting { get; set; }
        public required DateTime RegisteredDate { get; set; }
        public long ExamId { get; set; }
        public Guid UserId { get; set; }
    }
}
