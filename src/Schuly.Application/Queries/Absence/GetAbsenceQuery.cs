using Mediator;

namespace Schuly.Application.Queries.Absence
{
    public class GetAbsenceQuery : IRequest
    {
    }

    public class GetAbsenceQueryHandler : IRequestHandler<GetAbsenceQuery>
    {
        public ValueTask<Unit> Handle(GetAbsenceQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
