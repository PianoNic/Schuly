using Mediator;

namespace Schuly.Application.Commands.Exam
{
    public class DeleteExamCommand : IRequest
    {
    }

    public class DeleteExamCommandHandler : IRequestHandler<DeleteExamCommand>
    {
        public ValueTask<Unit> Handle(DeleteExamCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
