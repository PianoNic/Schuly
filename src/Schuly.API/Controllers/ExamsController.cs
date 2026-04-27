using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Exam;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Exam;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ExamsController(IMediator mediator) : ControllerBase
    {
        [HttpGet("search")]
        [ProducesResponseType(typeof(ExamDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetExam([FromQuery] long examId, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetExamQuery(examId), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ExamDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetExams(CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetExamsQuery(), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> AddExam([FromBody] CreateExamCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPost("grade")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> AddGradeToExam([FromBody] AddGradeToExamCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateExam([FromBody] UpdateExamCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpDelete("{id:long}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> DeleteExam(long id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new DeleteExamCommand(id), cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }
    }
}
