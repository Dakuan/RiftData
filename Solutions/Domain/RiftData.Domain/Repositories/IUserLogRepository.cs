using System.Collections.Generic;
using RiftData.Domain.Enums;
using RiftData.Domain.Logs;

namespace RiftData.Domain.Repositories
{
    public interface IUserLogRepository
    {
        AddResult Add(string userName, string message);

        IList<UserLog> GetAll();
    }
}
