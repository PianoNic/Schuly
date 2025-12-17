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
    public class UsersController : ControllerBase
    {
        private readonly IMediator _mediator;
        public UsersController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost("login")]
        [AllowAnonymous]
        [ProducesResponseType(typeof(LoginResponse), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<ActionResult<LoginResponse>> Login(LoginCommand loginCommand)
        {
            var result = await _mediator.Send(loginCommand, HttpContext.RequestAborted);
            if (!result.Success)
                return Unauthorized(result);
            return Ok(result);
        }

        [HttpGet("search")]
        [ProducesResponseType(typeof(UserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<UserDto>> GetUser([FromQuery] GetUserQuery getUser)
        {
            var result = await _mediator.Send(getUser, HttpContext.RequestAborted);
            if (result == null)
                return NotFound();
            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<UserDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<UserDto>>> GetUsers()
        {
            return Ok(await _mediator.Send(new GetUsersQuery(), HttpContext.RequestAborted));
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> CreateUser(CreateUserCommand createUser)
        {
            await _mediator.Send(createUser, HttpContext.RequestAborted);
            return Created();
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> UpdateUser(UpdateUserCommand updateUser)
        {
            await _mediator.Send(updateUser, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult> DeleteUser(DeleteUserCommand deleteUser)
        {
            await _mediator.Send(deleteUser, HttpContext.RequestAborted);
            return NoContent();
        }
    }
}
