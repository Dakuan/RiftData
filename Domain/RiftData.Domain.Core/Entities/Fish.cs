using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Fish : EntityBase, IPhotoSubject
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

        public IList<Photo> Photos{ get; internal set; }
    }
}
