using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Agenda;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.Agenda;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class AgendasController : ControllerBase
    {
        private readonly IMediator _mediator;
        public AgendasController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<AgendaEntryDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<AgendaEntryDto>>> GetAgendas()
        {
            return Ok(await _mediator.Send(new GetAgendasQuery(), HttpContext.RequestAborted));
        }

        [HttpGet("search")]
        [ProducesResponseType(typeof(AgendaEntryDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<AgendaEntryDto>> GetAgenda([FromQuery] GetAgendaQuery getAgenda)
        {
            var result = await _mediator.Send(getAgenda, HttpContext.RequestAborted);
            if (result == null)
                return NotFound();
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> CreateEntry(CreateAgendaEntryCommand createAgendaEntry)
        {
            await _mediator.Send(createAgendaEntry, HttpContext.RequestAborted);
            return Created();
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> UpdateEntry(UpdateAgendaEntryCommand updateAgendaEntry)
        {
            await _mediator.Send(updateAgendaEntry, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult> DeleteEntry(DeleteAgendaEntryCommand deleteAgendaEntry)
        {
            await _mediator.Send(deleteAgendaEntry, HttpContext.RequestAborted);
            return NoContent();
        }
    }
}
