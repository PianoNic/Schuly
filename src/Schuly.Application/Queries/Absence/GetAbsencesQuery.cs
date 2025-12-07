using Mediator;

namespace Schuly.Application.Queries.Absence
{
    public class GetAbsencesQuery : IRequest
    {
    }

    public class GetAbsencesQueryHandler : IRequestHandler<GetAbsencesQuery>
    {
        public ValueTask<Unit> Handle(GetAbsencesQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
