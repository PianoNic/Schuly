using Schuly.Domain.Enums;

namespace Schuly.Application.Authorization
{
    public interface IHasAuthorization
    {
        Roles GetRequiredRole();
    }
}
