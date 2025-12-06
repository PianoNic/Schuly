using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class Grade : Base
    {
        public decimal Score { get; set; }
        public decimal Weighting { get; set; }
        public DateTime? RegisteredDate { get; set; }

        public long ExamId { get; set; }
        public long UserId { get; set; }
        public required Exam Exam { get; set; }
        public required User User { get; set; }
    }
}
