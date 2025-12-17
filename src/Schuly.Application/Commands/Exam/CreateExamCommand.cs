using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.Exam
{
    public class CreateExamCommand : IRequest, IHasAuthorization
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public ExamType Type { get; set; }
        public required Guid ClassId { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Teacher;
        }
    }

    public class CreateExamCommandHandler : IRequestHandler<CreateExamCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateExamCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(CreateExamCommand request, CancellationToken cancellationToken)
        {
            await _dbContext.Exams.AddAsync(new Domain.Exam
            {
                Name = request.Name,
                Description = request.Description,
                Type = request.Type,
                ClassId = request.ClassId
            }, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
