using Mediator;

namespace Schuly.Application.Queries.Class
{
    public class GetClassQuery : IRequest
    {
    }

    public class GetClassQueryHandler : IRequestHandler<GetClassQuery>
    {
        public ValueTask<Unit> Handle(GetClassQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
