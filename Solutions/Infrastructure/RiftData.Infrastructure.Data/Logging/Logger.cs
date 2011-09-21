namespace RiftData.Infrastructure.Data.Logging
{
    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;

    public interface ILogger
    {
        void LogAdd(IEntity updatedEntity, string userName);

        void LogUpdate(IEntity updatedEntity, string userName);
    }

    public class Logger : ILogger
    {
        private readonly IUserLogRepository userLogRepository;

        public Logger(IUserLogRepository userLogRepository)
        {
            this.userLogRepository = userLogRepository;
        }

        public void LogAdd(IEntity updatedEntity, string userName)
        {
            var message = string.Format("{0} added {1}", userName, updatedEntity.Name);

            this.userLogRepository.Add(userName, message);
        }

        public void LogUpdate(IEntity updatedEntity, string userName)
        {
            var message = string.Format("{0} updated {1}", userName, updatedEntity.Name);

            this.userLogRepository.Add(userName, message);
        }
    }
}