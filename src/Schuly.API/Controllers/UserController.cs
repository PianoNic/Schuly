using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands;
using Schuly.Application.Queries;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IMediator _mediator;
        public UserController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<ActionResult> GetUser()
        {
            await _mediator.Send(new GetUserInfoQuery());
            return Ok();
        }

        [HttpGet("Users", Name = "Users")]
        public async Task<ActionResult> GetUsers()
        {
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateUser()
        {
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateUser()
        {
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteUser(long userId)
        {
            await _mediator.Send(new RemoveUserCommand(userId));
            return Ok();
        }
    }
}
