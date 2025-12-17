using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class UpdateUserCommand : IRequest, IHasAuthorization
    {
        public required Guid UserId { get; set; }
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
        public DateOnly? LeaveDate { get; set; }
        public required Roles Role { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users
                .SingleOrDefaultAsync(u => u.Id == request.UserId, cancellationToken);

            if (user != null)
            {
                user.FirstName = request.FirstName;
                user.LastName = request.LastName;
                user.Email = request.Email;
                user.PrivateEmail = request.PrivateEmail;
                user.PhoneNumber = request.PhoneNumber;
                user.Street = request.Street;
                user.City = request.City;
                user.Zip = request.Zip;
                user.Birthday = request.Birthday;
                user.EntryDate = request.EntryDate;
                user.LeaveDate = request.LeaveDate;
                user.Role = request.Role;

                await _dbContext.SaveChangesAsync(cancellationToken);
            }

            return Unit.Value;
        }
    }
}
