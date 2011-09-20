using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Logging
{
    public interface ILogger
    {
        void LogUpdate(IEntity updatedEntity, string userName);
        void LogAdd(IEntity updatedEntity, string userName);
    }

    public class Logger : ILogger
    {
        private readonly IUserLogRepository userLogRepository;

        public Logger(IUserLogRepository userLogRepository)
        {
            this.userLogRepository = userLogRepository;
        }

        public void LogUpdate(IEntity updatedEntity, string userName)
        {
            var message = string.Format("{0} updated {1}", userName, updatedEntity.Name);

            this.userLogRepository.Add(userName, message);
        }

        public void LogAdd(IEntity updatedEntity, string userName)
        {
            var message = string.Format("{0} added {1}", userName, updatedEntity.Name);

            this.userLogRepository.Add(userName, message);
        }
    }
}