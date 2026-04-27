using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.User;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.User;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class UsersController(IMediator mediator) : ControllerBase
    {
        [HttpGet("search")]
        [ProducesResponseType(typeof(UserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetUser([FromQuery] Guid userId, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetUserQuery(userId), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<UserDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetUsers(CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new GetUsersQuery(), cancellationToken);
            if (result.IsSuccess)
                return Ok(result.Value);

            return BadRequest(result.Error);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateUser([FromBody] CreateUserCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateUser([FromBody] UpdateUserCommand command, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(command, cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }

        [HttpDelete("{id:guid}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> DeleteUser(Guid id, CancellationToken cancellationToken)
        {
            var result = await mediator.Send(new DeleteUserCommand(id), cancellationToken);
            if (result.IsSuccess)
                return NoContent();

            return BadRequest(result.Error);
        }
    }
}
