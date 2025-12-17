using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.User;
using Schuly.Application.Queries.User;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IMediator _mediator;

        public AuthController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<ActionResult<RegisterResponse>> Register([FromBody] RegisterCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<ActionResult<LoginResponse>> Login([FromBody] LoginCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return Unauthorized(result);
            }

            return Ok(result);
        }

        [HttpGet("me")]
        [Authorize]
        public async Task<ActionResult<GetCurrentUserQuery>> GetCurrentUser()
        {
            var result = await _mediator.Send(new GetCurrentUserQuery());

            if (result == null)
            {
                return Unauthorized();
            }

            return Ok(result);
        }
    }
}
