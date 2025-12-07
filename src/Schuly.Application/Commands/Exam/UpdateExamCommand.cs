using Mediator;

namespace Schuly.Application.Commands.Exam
{
    public class UpdateExamCommand : IRequest
    {
    }

    public class UpdateExamCommandHandler : IRequestHandler<UpdateExamCommand>
    {
        public ValueTask<Unit> Handle(UpdateExamCommand request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
