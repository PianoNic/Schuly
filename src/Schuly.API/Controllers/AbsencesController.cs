using Mediator;
using Microsoft.AspNetCore.Mvc;

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

        [HttpGet("Absences", Name = "Absences")]
        public async Task<ActionResult> GetAbsences()
        {
            return Ok();
        }

        [HttpGet("Absence", Name = "Absence")]
        public async Task<ActionResult> GetAbsence()
        {
            return Ok();
        }

        [HttpPost("Absence", Name = "Absence")]
        public async Task<ActionResult> CreateAbsence()
        {
            return Created();
        }

        [HttpPut("Absence", Name = "Absence")]
        public async Task<ActionResult> UpdateAbsence()
        {
            return Ok();
        }

        [HttpDelete("Absence", Name = "Absence")]
        public async Task<ActionResult> RemoveAbsence()
        {
            return Ok();
        }
    }
}
