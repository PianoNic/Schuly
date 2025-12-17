using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.User
{
    public class CreateUserCommand : IRequest, IHasAuthorization
    {
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

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateUserCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.AddAsync(new Domain.User()
            {
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
                Role = request.Role
            });

            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
