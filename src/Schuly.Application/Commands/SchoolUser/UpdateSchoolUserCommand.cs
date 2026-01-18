using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.SchoolUser
{
    public class UpdateSchoolUserCommand : IRequest, IHasAuthorization
    {
        public required long SchoolUserId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? PrivateEmail { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? Zip { get; set; }
        public DateOnly? LeaveDate { get; set; }
        public UserState? State { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class UpdateSchoolUserCommandHandler : IRequestHandler<UpdateSchoolUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateSchoolUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateSchoolUserCommand request, CancellationToken cancellationToken)
        {
            var schoolUser = await _dbContext.SchoolUsers
                .FirstOrDefaultAsync(su => su.Id == request.SchoolUserId, cancellationToken);

            if (schoolUser == null)
                throw new InvalidOperationException($"SchoolUser with ID '{request.SchoolUserId}' not found.");

            if (!string.IsNullOrEmpty(request.FirstName))
                schoolUser.FirstName = request.FirstName;

            if (!string.IsNullOrEmpty(request.LastName))
                schoolUser.LastName = request.LastName;

            if (!string.IsNullOrEmpty(request.Email))
                schoolUser.Email = request.Email;

            if (!string.IsNullOrEmpty(request.PrivateEmail))
                schoolUser.PrivateEmail = request.PrivateEmail;

            if (!string.IsNullOrEmpty(request.PhoneNumber))
                schoolUser.PhoneNumber = request.PhoneNumber;

            if (!string.IsNullOrEmpty(request.Street))
                schoolUser.Street = request.Street;

            if (!string.IsNullOrEmpty(request.City))
                schoolUser.City = request.City;

            if (!string.IsNullOrEmpty(request.Zip))
                schoolUser.Zip = request.Zip;

            if (request.LeaveDate.HasValue)
                schoolUser.LeaveDate = request.LeaveDate;

            if (request.State.HasValue)
                schoolUser.State = request.State.Value;

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
