using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Queries;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgendaController : ControllerBase
    {
        private readonly IMediator _mediator;
        public AgendaController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("Absence", Name = "Absence")]
        public async Task<ActionResult> GetAgenda()
        {
            return Ok();
        }

        [HttpPost("Absence", Name = "Absence")]
        public async Task<ActionResult> CreateEntry()
        {
            return Created();
        }

        [HttpPut("Absence", Name = "Absence")]
        public async Task<ActionResult> UpdateEntry()
        {
            return Ok();
        }

        [HttpDelete("Absence", Name = "Absence")]
        public async Task<ActionResult> DeleteEntry()
        {
            return Ok();
        }
    }
}
