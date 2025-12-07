using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Queries;

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
        public async Task<ActionResult> GetAgenda()
        {
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateEntry()
        {
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateEntry()
        {
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteEntry()
        {
            return Ok();
        }
    }
}
