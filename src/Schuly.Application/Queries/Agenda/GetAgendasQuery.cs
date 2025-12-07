using Mediator;

namespace Schuly.Application.Queries.Agenda
{
    public class GetAgendasQuery : IRequest
    {
    }

    public class GetAgendasQueryHandler : IRequestHandler<GetAgendasQuery>
    {
        public ValueTask<Unit> Handle(GetAgendasQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
