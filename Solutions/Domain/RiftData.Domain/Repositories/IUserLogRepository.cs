namespace RiftData.Domain.Repositories
{
    using System.Collections.Generic;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Logs;

    public interface IUserLogRepository
    {
        AddResult Add(string userName, string message);

        IList<UserLog> GetAll();
    }
}