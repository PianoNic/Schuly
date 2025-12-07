using Mediator;

namespace Schuly.Application.Queries.Exam
{
    public class GetExamQuery : IRequest
    {
    }

    public class GetExamQueryHandler : IRequestHandler<GetExamQuery>
    {
        public ValueTask<Unit> Handle(GetExamQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
