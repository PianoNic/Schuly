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
    public class SchoolUsersController(IMediator mediator) : ControllerBase
    {
        [HttpGet("{id:long}")]
        [ProducesResponseType(typeof(SchoolUserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetSchoolUser(long id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetSchoolUserQuery(id), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<SchoolUserDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetSchoolUsers([FromQuery] Guid? applicationUserId, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetSchoolUsersQuery(applicationUserId), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPost]
        [ProducesResponseType(typeof(long), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateSchoolUser([FromBody] CreateSchoolUserCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateSchoolUser([FromBody] UpdateSchoolUserCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpDelete("{id:long}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> DeleteSchoolUser(long id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new DeleteSchoolUserCommand(id), cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }
    }
}
