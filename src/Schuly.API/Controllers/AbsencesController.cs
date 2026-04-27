using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Absence;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Absence;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class AbsencesController(IMediator mediator) : ControllerBase
    {
        [HttpGet]
        [ProducesResponseType(typeof(List<AbsenceDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetAbsences(CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetAbsencesQuery(), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpGet("search")]
        [ProducesResponseType(typeof(AbsenceDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetAbsence([FromQuery] long absenceId, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetAbsenceQuery(absenceId), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateAbsence([FromBody] CreateAbsenceCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateAbsence([FromBody] UpdateAbsenceCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpDelete("{id:long}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> RemoveAbsence(long id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new RemoveAbsenceCommand(id), cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }
    }
}
