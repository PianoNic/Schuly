using Mediator;

namespace Schuly.Application.Queries.User
{
    public class GetUserQuery : IRequest
    {
        public required long UserId { get; set; }
    }

    public class GetUserQueryHandler : IRequestHandler<GetUserQuery>
    {
        public ValueTask<Unit> Handle(GetUserQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
