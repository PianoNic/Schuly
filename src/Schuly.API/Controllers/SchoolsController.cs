using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.School;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.School;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class SchoolsController : ControllerBase
    {
        private readonly IMediator _mediator;

        public SchoolsController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<SchoolDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<List<SchoolDto>>> GetSchools()
        {
            var result = await _mediator.Send(
                new GetSchoolsQuery(),
                HttpContext.RequestAborted);

            return Ok(result);
        }

        [HttpGet("my-schools")]
        [ProducesResponseType(typeof(List<SchoolDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<ActionResult<List<SchoolDto>>> GetMySchools()
        {
            var result = await _mediator.Send(
                new GetMySchoolsQuery(),
                HttpContext.RequestAborted);

            return Ok(result);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(typeof(SchoolDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<ActionResult<SchoolDto>> GetSchool(long id)
        {
            var result = await _mediator.Send(
                new GetSchoolQuery { SchoolId = id },
                HttpContext.RequestAborted);

            if (result == null)
                return NotFound();

            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(typeof(long), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<long>> CreateSchool(CreateSchoolCommand command)
        {
            var id = await _mediator.Send(command, HttpContext.RequestAborted);
            return CreatedAtAction(nameof(GetSchool), new { id }, id);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult> UpdateSchool(UpdateSchoolCommand command)
        {
            await _mediator.Send(command, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult> DeleteSchool(long id)
        {
            await _mediator.Send(
                new DeleteSchoolCommand { Id = id },
                HttpContext.RequestAborted);

            return NoContent();
        }
    }
}
