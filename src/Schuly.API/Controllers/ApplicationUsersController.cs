using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.ApplicationUser;
using Schuly.Application.Dtos;
using Schuly.Application.Queries.ApplicationUser;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ApplicationUsersController : ControllerBase
    {
        private readonly IMediator _mediator;

        public ApplicationUsersController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("{id}")]
        [ProducesResponseType(typeof(ApplicationUserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<ApplicationUserDto>> GetApplicationUser(Guid id)
        {
            var result = await _mediator.Send(
                new GetApplicationUserQuery { ApplicationUserId = id },
                HttpContext.RequestAborted);

            if (result == null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ApplicationUserDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<List<ApplicationUserDto>>> GetApplicationUsers()
        {
            var result = await _mediator.Send(
                new GetApplicationUsersQuery(),
                HttpContext.RequestAborted);

            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(typeof(Guid), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult<Guid>> CreateApplicationUser(CreateApplicationUserCommand command)
        {
            var id = await _mediator.Send(command, HttpContext.RequestAborted);
            return CreatedAtAction(nameof(GetApplicationUser), new { id }, id);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        public async Task<ActionResult> UpdateApplicationUser(UpdateApplicationUserCommand command)
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
        public async Task<ActionResult> DeleteApplicationUser(Guid id)
        {
            await _mediator.Send(
                new DeleteApplicationUserCommand { ApplicationUserId = id },
                HttpContext.RequestAborted);

            return NoContent();
        }
    }
}
