using Mediator;

namespace Schuly.Application.Commands.Exam
{
    public class CreateExamCommand : IRequest
    {
    }

    public class CreateExamCommandHandler : IRequestHandler<CreateExamCommand>
    {
        public ValueTask<Unit> Handle(CreateExamCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
