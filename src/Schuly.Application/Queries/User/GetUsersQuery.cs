using Mediator;

namespace Schuly.Application.Queries.User
{
    public class GetUsersQuery : IRequest
    {
    }

    public class GetUsersQueryHandler : IRequestHandler<GetUsersQuery>
    {
        public ValueTask<Unit> Handle(GetUsersQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
