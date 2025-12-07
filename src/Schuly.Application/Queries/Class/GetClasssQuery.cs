using Mediator;

namespace Schuly.Application.Queries.Class
{
    public class GetClasssQuery : IRequest
    {
    }

    public class GetClasssQueryHandler : IRequestHandler<GetClasssQuery>
    {
        public ValueTask<Unit> Handle(GetClasssQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
