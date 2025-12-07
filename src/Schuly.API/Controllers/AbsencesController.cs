using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Absence;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Absence;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AbsencesController : ControllerBase
    {
        private readonly IMediator _mediator;
        public AbsencesController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<AbsenceDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<AbsenceDto>>> GetAbsences()
        {
            return Ok(await _mediator.Send(new GetAbsencesQuery(), HttpContext.RequestAborted));
        }

        [HttpGet("search")]
        [ProducesResponseType(typeof(AbsenceDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<AbsenceDto>> GetAbsence([FromQuery] GetAbsenceQuery getAbsence)
        {
            var result = await _mediator.Send(getAbsence, HttpContext.RequestAborted);
            if (result == null)
                return NotFound();
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> CreateAbsence(CreateAbsenceCommand createAbsenceCommand)
        {
            await _mediator.Send(createAbsenceCommand, HttpContext.RequestAborted);
            return Created();
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> UpdateAbsence(UpdateAbsenceCommand updateAbsenceCommand)
        {
            await _mediator.Send(updateAbsenceCommand, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult> RemoveAbsence(RemoveAbsenceCommand removeAbsence)
        {
            await _mediator.Send(removeAbsence, HttpContext.RequestAborted);
            return NoContent();
        }
    }
}
