using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Class;
using Schuly.Application.Dtos;
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

        [HttpGet("search")]
        [ProducesResponseType(typeof(ClassDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ClassDto>> GetClass([FromQuery] GetClassQuery getClass)
        {
            var result = await _mediator.Send(getClass, HttpContext.RequestAborted);
            if (result == null)
                return NotFound();
            return Ok(result);
        }

        [HttpGet]
        [ProducesResponseType(typeof(List<ClassDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ClassDto>>> GetClasses()
        {
            return Ok(await _mediator.Send(new GetClasssQuery(), HttpContext.RequestAborted));
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> CreateClass(CreateClassCommand createClass)
        {
            await _mediator.Send(createClass, HttpContext.RequestAborted);
            return Created();
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult> UpdateClass(UpdateClassCommand updateClass)
        {
            await _mediator.Send(updateClass, HttpContext.RequestAborted);
            return Ok();
        }

        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult> DeleteClass(DeleteClassCommand deleteClass)
        {
            await _mediator.Send(deleteClass, HttpContext.RequestAborted);
            return NoContent();
        }
    }
}
