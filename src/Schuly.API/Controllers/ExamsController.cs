using Mediator;
using Microsoft.AspNetCore.Mvc;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ExamsController : ControllerBase
    {
        private readonly IMediator _mediator;
        public ExamsController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("search", Name = "search")]
        public async Task<ActionResult> GetExams()
        {
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetExam()
        {
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> AddExam()
        {
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateExam()
        {
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteExam()
        {
            return Ok();
        }
    }
}
