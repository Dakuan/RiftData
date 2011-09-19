namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class Genus : IEntity
    {
        public virtual GenusType GenusType { get; set; }

        public bool HasFish { get; set; }

        public int Id { get; set; }

        public string Name { get; set; }

        public int NumberOfSpecies
        {
            get
            {
                return this.Species.Count;
            }
        }

        public virtual ICollection<Species> Species { get; set; }

        public override string ToString()
        {
            return this.Name;
        }
    }
}