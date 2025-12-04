using Mediator;

namespace Schuly.Application.Queries
{
    public class GetUserInfoQuery : IRequest
    {
    }

    public class GetUserInfoQueryHandler : IRequestHandler<GetUserInfoQuery>
    {
        public ValueTask<Unit> Handle(GetUserInfoQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
