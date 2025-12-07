using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.User;
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
        public async Task<ActionResult> GetUser([FromQuery] GetUserQuery getUser)
        {
            await _mediator.Send(getUser);
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetUsers()
        {
            await _mediator.Send(new GetUsersQuery());
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateUser(CreateUserCommand createUser)
        {
            await _mediator.Send(createUser);
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateUser(UpdateUserCommand updateUser)
        {
            await _mediator.Send(updateUser);
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteUser(DeleteUserCommand deleteUser)
        {
            await _mediator.Send(deleteUser);
            return Ok();
        }
    }
}
