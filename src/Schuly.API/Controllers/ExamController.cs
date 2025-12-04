using Mediator;
using Microsoft.AspNetCore.Mvc;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ExamController : ControllerBase
    {
        private readonly IMediator _mediator;
        public ExamController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("Exams", Name = "Exams")]
        public async Task<ActionResult> GetExams()
        {
            return Ok();
        }

        [HttpGet("Exam", Name = "Exam")]
        public async Task<ActionResult> GetExam()
        {
            return Ok();
        }

        [HttpPost("Exam", Name = "Exam")]
        public async Task<ActionResult> AddExam()
        {
            return Created();
        }

        [HttpPut("Exam", Name = "Exam")]
        public async Task<ActionResult> UpdateExam()
        {
            return Ok();
        }

        [HttpDelete("Exam", Name = "Exam")]
        public async Task<ActionResult> DeleteExam()
        {
            return Ok();
        }
    }
}
