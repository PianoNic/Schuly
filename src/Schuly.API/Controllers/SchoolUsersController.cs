using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.SchoolUser;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.SchoolUser;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class SchoolUsersController : ControllerBase
    {
        private readonly IMediator _mediator;

        public SchoolUsersController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("{id}")]
        [ProducesResponseType(typeof(SchoolUserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<SchoolUserDto>> GetSchoolUser(long id)
        {
            var result = await _mediator.Send(
                new GetSchoolUserQuery { SchoolUserId = id },
                HttpContext.RequestAborted);

            if (result == null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<SchoolUserDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<List<SchoolUserDto>>> GetSchoolUsers([FromQuery] Guid? applicationUserId)
        {
            var result = await _mediator.Send(
                new GetSchoolUsersQuery { ApplicationUserId = applicationUserId },
                HttpContext.RequestAborted);

            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(typeof(long), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<long>> CreateSchoolUser(CreateSchoolUserCommand command)
        {
            var id = await _mediator.Send(command, HttpContext.RequestAborted);
            return CreatedAtAction(nameof(GetSchoolUser), new { id }, id);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult> UpdateSchoolUser(UpdateSchoolUserCommand command)
        {
            await _mediator.Send(command, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult> DeleteSchoolUser(long id)
        {
            await _mediator.Send(
                new DeleteSchoolUserCommand { SchoolUserId = id },
                HttpContext.RequestAborted);

            return NoContent();
        }
    }
}
