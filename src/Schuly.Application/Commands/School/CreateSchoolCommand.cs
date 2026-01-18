using Mediator;
using Schuly.Application.Authorization;
using Schuly.Application.Mappers;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.School
{
    public class CreateSchoolCommand : IRequest<long>, IHasAuthorization
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Website { get; set; }
        public string? Street { get; set; }
        public string? City { get; set; }
        public string? State { get; set; }
        public string? Zip { get; set; }
        public string? Country { get; set; }

        public Roles GetRequiredRole()
        {
            return Roles.Administrator;
        }
    }

    public class CreateSchoolCommandHandler : IRequestHandler<CreateSchoolCommand, long>
    {
        private readonly SchulyDbContext _dbContext;

        public CreateSchoolCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<long> Handle(CreateSchoolCommand request, CancellationToken cancellationToken)
        {
            var school = new Domain.School
            {
                Name = request.Name,
                Description = request.Description,
                Email = request.Email,
                PhoneNumber = request.PhoneNumber,
                Website = request.Website,
                Street = request.Street,
                City = request.City,
                State = request.State,
                Zip = request.Zip,
                Country = request.Country
            };

            await _dbContext.Schools.AddAsync(school, cancellationToken);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return school.Id;
        }
    }
}
