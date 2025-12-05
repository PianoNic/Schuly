using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class ExamAverage
    {
        public long Id { get; set; }
        public decimal Grade { get; set; }
        public required Exam Exam { get; set; }
        public required Class Class { get; set; }
    }
}
