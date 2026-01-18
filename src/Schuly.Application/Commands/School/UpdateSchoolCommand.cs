using Mediator;
using Schuly.Application.Authorization;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Commands.School
{
    public class UpdateSchoolCommand : IRequest, IHasAuthorization
    {
        public required long Id { get; set; }
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

    public class UpdateSchoolCommandHandler : IRequestHandler<UpdateSchoolCommand>
    {
        private readonly SchulyDbContext _dbContext;

        public UpdateSchoolCommandHandler(SchulyDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async ValueTask<Unit> Handle(UpdateSchoolCommand request, CancellationToken cancellationToken)
        {
            var school = await _dbContext.Schools.FindAsync(new object[] { request.Id }, cancellationToken: cancellationToken);
            if (school == null)
                throw new InvalidOperationException($"School with ID {request.Id} not found");

            school.Name = request.Name;
            school.Description = request.Description;
            school.Email = request.Email;
            school.PhoneNumber = request.PhoneNumber;
            school.Website = request.Website;
            school.Street = request.Street;
            school.City = request.City;
            school.State = request.State;
            school.Zip = request.Zip;
            school.Country = request.Country;

            _dbContext.Schools.Update(school);
            await _dbContext.SaveChangesAsync(cancellationToken);

            return Unit.Value;
        }
    }
}
