using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands;
using Schuly.Application.Queries.User;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly IMediator _mediator;
        public UsersController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("search", Name = "search")]
        public async Task<ActionResult> GetUser([FromQuery] GetUserQuery userInfoQuery)
        {
            await _mediator.Send(userInfoQuery);
            return Ok();
        }

        [HttpGet]
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
        public async Task<ActionResult> DeleteUser(RemoveUserCommand removeUserCommand)
        {
            await _mediator.Send(removeUserCommand);
            return Ok();
        }
    }
}
