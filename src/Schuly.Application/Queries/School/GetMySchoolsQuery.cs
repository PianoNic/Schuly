using Mediator;
using Microsoft.EntityFrameworkCore;
using Schuly.Application.Authorization;
using Schuly.Application.Dtos;
using Schuly.Application.Mappers;
using Schuly.Application.Services.Interfaces;
using Schuly.Domain.Enums;
using Schuly.Infrastructure;

namespace Schuly.Application.Queries.School
{
    public class GetMySchoolsQuery : IRequest<List<SchoolDto>>, IHasAuthorization
    {
        public Roles GetRequiredRole()
        {
            return Roles.Student;
        }
    }

    public class GetMySchoolsQueryHandler : IRequestHandler<GetMySchoolsQuery, List<SchoolDto>>
    {
        private readonly SchulyDbContext _dbContext;
        private readonly IUserService _userService;

        public GetMySchoolsQueryHandler(SchulyDbContext dbContext, IUserService userService)
        {
            _dbContext = dbContext;
            _userService = userService;
        }

        public async ValueTask<List<SchoolDto>> Handle(GetMySchoolsQuery request, CancellationToken cancellationToken)
        {
            var currentUser = await _userService.GetCurrentUserAsync(cancellationToken);
            if (currentUser == null)
                return new List<SchoolDto>();

            var schools = await _dbContext.SchoolUsers
                .Where(su => su.ApplicationUserId == currentUser.Id)
                .Include(su => su.School)
                .Select(su => su.School!)
                .Distinct()
                .ToListAsync(cancellationToken);

            return schools.ToDto();
        }
    }
}
