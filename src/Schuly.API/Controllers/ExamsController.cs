using Mediator;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.Exam;
using Schuly.Application.Commands.User;
using Schuly.Application.Queries.Exam;

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
        public async Task<ActionResult> GetExam(GetExamQuery getExam)
        {
            await _mediator.Send(getExam);
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult> GetExams()
        {
            await _mediator.Send(new GetExamsQuery());
            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult> AddExam(CreateExamCommand createExam)
        {
            await _mediator.Send(createExam);
            return Created();
        }

        [HttpPut]
        public async Task<ActionResult> UpdateExam(UpdateExamCommand updateExam)
        {
            await _mediator.Send(updateExam);
            return Ok();
        }

        [HttpDelete]
        public async Task<ActionResult> DeleteExam(DeleteExamCommand deleteExam)
        {
            await _mediator.Send(deleteExam);
            return Ok();
        }
    }
}
