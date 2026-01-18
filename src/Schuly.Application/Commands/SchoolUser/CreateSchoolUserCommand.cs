using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public class CreateSchoolUserCommand : IRequest<long>, IHasAuthorization
    {
        public required Guid ApplicationUserId { get; set; }
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Email { get; set; }
        public string? PrivateEmail { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? Zip { get; set; }
        public required DateOnly Birthday { get; set; }
        public required DateOnly EntryDate { get; set; }
        public required Roles Role { get; set; }
        public string? StudentNumber { get; set; }
        public string? TeacherCode { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class CreateSchoolUserCommandHandler : IRequestHandler<CreateSchoolUserCommand, long>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateSchoolUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<long> Handle(CreateSchoolUserCommand request, CancellationToken cancellationToken)
        {
            var schoolUser = new Domain.SchoolUser
            {
                ApplicationUserId = request.ApplicationUserId,
                FirstName = request.FirstName,
                LastName = request.LastName,
                Email = request.Email,
                PrivateEmail = request.PrivateEmail,
                PhoneNumber = request.PhoneNumber,
                Street = request.Street,
                City = request.City,
                Zip = request.Zip,
                Birthday = request.Birthday,
                EntryDate = request.EntryDate,
                Role = request.Role,
                State = UserState.Active,
                StudentNumber = request.StudentNumber,
                TeacherCode = request.TeacherCode
            };

            await _dbContext.SchoolUsers.AddAsync(schoolUser, cancellationToken);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return schoolUser.Id;
        }
    }
}
