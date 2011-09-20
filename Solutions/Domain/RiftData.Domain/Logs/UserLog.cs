using System;

namespace RiftData.Domain.Logs
{
    public class UserLog
    {
        public int Id { get; set; }

        public DateTime Date { get; set; }

        public string UserName { get; set; }

        public string Message { get; set; }
    }
}
