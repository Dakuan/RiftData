using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Genus : EntityBase
    {
        public Genus(int id) : base(id)
        {
        }

        public string Name { get; internal set; }

        public IList<Species> Species { get; internal set; }

        public GenusType GenusType { get; internal set; }

        public bool HasFish { get; internal set; }

        public override string ToString()
        {
            return this.Name;
        }
    }
}