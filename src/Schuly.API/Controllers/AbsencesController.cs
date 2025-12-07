using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Absence;
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
        public async Task<ActionResult> GetAbsences()
        {
            await _mediator.Send(new GetAbsencesQuery());
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetAbsence(GetAbsencesQuery getAbsences)
        {
            await _mediator.Send(getAbsences);
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateAbsence(CreateAbsenceCommand createAbsenceCommand)
        {
            await _mediator.Send(createAbsenceCommand);
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateAbsence(UpdateAbsenceCommand updateAbsenceCommand)
        {
            await _mediator.Send(updateAbsenceCommand);
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> RemoveAbsence(RemoveAbsenceCommand removeAbsence)
        {
            await _mediator.Send(removeAbsence);
            return Ok();
        }
    }
}
