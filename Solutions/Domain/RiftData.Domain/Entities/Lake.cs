namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class Lake : IEntity
    {
        public virtual ICollection<GenusType> GenusTypes { get; set; }

        public int Id { get; set; }

        public string Name { get; set; }
    }
}