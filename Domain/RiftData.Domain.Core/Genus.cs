namespace RiftData.Domain.Core
{
    using System.Collections.Generic;

    public class Genus : EntityBase
    {
        public Genus(int id, string name) : base(id)
        {
            this.Name = name;
        }

        public string Name { get; private set; }

        public IList<Species> Species { get; set; }

        public override string ToString()
        {
            return this.Name;
        }
    }
}