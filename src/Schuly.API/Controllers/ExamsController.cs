using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Exam;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Exam;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ExamsController : ControllerBase
    {
        private readonly IMediator _mediator;
        public ExamsController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("search")]
        [ProducesResponseType(typeof(ExamDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ExamDto>> GetExam([FromQuery] GetExamQuery getExam)
        {
            var result = await _mediator.Send(getExam, HttpContext.RequestAborted);
            if (result == null)
                return NotFound();
            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ExamDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ExamDto>>> GetExams()
        {
            return Ok(await _mediator.Send(new GetExamsQuery(), HttpContext.RequestAborted));
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> AddExam(CreateExamCommand createExam)
        {
            await _mediator.Send(createExam, HttpContext.RequestAborted);
            return Created();
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> UpdateExam(UpdateExamCommand updateExam)
        {
            await _mediator.Send(updateExam, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult> DeleteExam(DeleteExamCommand deleteExam)
        {
            await _mediator.Send(deleteExam, HttpContext.RequestAborted);
            return NoContent();
        }
    }
}
