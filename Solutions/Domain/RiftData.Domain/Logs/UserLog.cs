namespace RiftData.Domain.Logs
{
    using System;

    public class UserLog
    {
        public DateTime Date { get; set; }

        public int Id { get; set; }

        public string Message { get; set; }

        public string UserName { get; set; }
    }
}