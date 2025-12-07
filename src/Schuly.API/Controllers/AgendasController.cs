using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Agenda;
using Schuly.Application.Queries.Agenda;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgendasController : ControllerBase
    {
        private readonly IMediator _mediator;
        public AgendasController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<ActionResult> GetAgendas()
        {
            await _mediator.Send(new GetAgendasQuery());
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetAgenda(GetAgendaQuery getAgenda)
        {
            await _mediator.Send(getAgenda);
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateEntry(CreateAgendaEntryCommand createAgendaEntry)
        {
            await _mediator.Send(createAgendaEntry);
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateEntry(UpdateAgendaEntryCommand updateAgendaEntry)
        {
            await _mediator.Send(updateAgendaEntry);
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteEntry(DeleteAgendaEntryCommand deleteAgendaEntry)
        {
            await _mediator.Send(deleteAgendaEntry);
            return Ok();
        }
    }
}
