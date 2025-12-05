using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class Grade
    {
        public long Id { get; set; }
        public decimal Score { get; set; }
        public decimal Weighting { get; set; }
        public required Exam Exam { get; set; }
        public required User User { get; set; }
    }
}
