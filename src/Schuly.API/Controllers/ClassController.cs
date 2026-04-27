using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Class;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Class;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ClassController(IMediator mediator) : ControllerBase
    {
        [HttpGet("search")]
        [ProducesResponseType(typeof(ClassDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetClass([FromQuery] Guid classId, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetClassQuery(classId), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ClassDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetClasses(CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetClassesQuery(), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateClass([FromBody] CreateClassCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPost("enrol-student")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> EnrolStudent([FromBody] EnrolStudentCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateClass([FromBody] UpdateClassCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpDelete("{id:guid}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> DeleteClass(Guid id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new DeleteClassCommand(id), cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }
    }
}
