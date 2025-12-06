using System;
using System.Collections.Generic;
using System.Text;

namespace Schuly.Domain
{
    public class ExamAverage : Base
    {
        public decimal Average { get; set; }

        public long ExamId { get; set; }
        public required Exam Exam { get; set; }
    }
}
