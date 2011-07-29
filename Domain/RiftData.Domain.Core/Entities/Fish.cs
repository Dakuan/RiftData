using System;

namespace RiftData.Domain.Entities
{
    public class Fish : EntityBase
    {
        public Fish(int id) : base(id)
        {
        }

        public Genus Genus { get; internal set; }

        public Species Species { get; internal set; }

        public Locale Locale { get; internal set; }

        public String FullName
        {
            get
            {
                return this.Species.Described
                           ? string.Format("{0} {1} '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name)
                           : string.Format(@"{0} sp ""{1}"" '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name);
            }
        }
    }
}
