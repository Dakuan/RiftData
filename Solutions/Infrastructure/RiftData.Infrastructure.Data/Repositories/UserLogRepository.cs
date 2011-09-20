using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Enums;
using RiftData.Domain.Logs;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class UserLogRepository : IUserLogRepository
    {
        private readonly RiftDataDataContext dataContext;

        public UserLogRepository(RiftDataDataContext dataContext)
        {
            this.dataContext = dataContext;
        }

        public AddResult Add(string userName, string message)
        {
            var log = new UserLog
                          {
                              Date = DateTime.Now,
                              Message = message,
                              UserName = userName
                          };

            try
            {
                this.dataContext.UserLogs.Add(log);

                this.dataContext.SaveChanges();
            }
            catch (Exception)
            {
                return AddResult.Failure;
            }

            return AddResult.Success;
        }

        public IList<UserLog> GetAll()
        {
            return this.dataContext.UserLogs.OrderByDescending(l => l.Date).ToList();
        }
    }
}
