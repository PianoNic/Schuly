namespace Schuly.Application.Dtos
{
    public class GradeDto
    {
        public Guid Id { get; set; }
        public decimal Score { get; set; }
        public decimal Weighting { get; set; }
        public Guid ExamId { get; set; }
        public Guid SchoolUserId { get; set; }
    }
}
