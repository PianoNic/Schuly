using Mediator;

namespace Schuly.Application.Queries.Exam
{
    public class GetExamsQuery : IRequest
    {
    }

    public class GetExamsQueryHandler : IRequestHandler<GetExamsQuery>
    {
        public ValueTask<Unit> Handle(GetExamsQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
