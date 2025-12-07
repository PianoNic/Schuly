using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Class;
using Schuly.Application.Queries.Class;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ClassController : ControllerBase
    {
        private readonly IMediator _mediator;
        public ClassController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("search", Name = "search")]
        public async Task<ActionResult> GetClass(GetClassQuery getClass)
        {
            await _mediator.Send(getClass);
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetClasses()
        {
            await _mediator.Send(new GetClasssQuery());
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> CreateClass(CreateClassCommand createClass)
        {
            await _mediator.Send(createClass);
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateClass(UpdateClassCommand updateClass)
        {
            await _mediator.Send(updateClass);
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteClass(DeleteClassCommand deleteClass)
        {
            await _mediator.Send(deleteClass);
            return Ok();
        }
    }
}
