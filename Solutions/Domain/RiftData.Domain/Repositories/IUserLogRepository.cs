using RiftData.Domain.Enums;

namespace RiftData.Domain.Repositories
{
    public interface IUserLogRepository
    {
        AddResult Add(string userName, string message);
    }
}
