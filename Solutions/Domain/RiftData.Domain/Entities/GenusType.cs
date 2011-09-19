namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class GenusType : IEntity
    {
        public string Description { get; set; }

        public virtual ICollection<Genus> Genus { get; set; }

        public int Id { get; set; }

        public virtual Lake Lake { get; set; }

        public string Name { get; set; }

        public int NumberOfGenera
        {
            get
            {
                return this.Genus.Count;
            }
        }
    }
}