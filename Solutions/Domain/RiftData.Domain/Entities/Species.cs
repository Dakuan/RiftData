using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Species : EntityBase, IPhotoSubject
    {
        public Species(int id) : base(id)
        {
        }

        public string Name { get; internal set; }

        public bool Described { get; internal set; }

        public Genus Genus { get; internal set; }

        public override string ToString()
        {
            return this.FullName;
        }

        public string FullName
        {
            get
            {
                return this.Described
                           ? string.Format("{0} {1}", this.Genus.Name, this.Name)
                           : string.Format(@"{0} sp ""{1}""", this.Genus.Name, this.Name);
            }
        }

        public bool HaveFish { get; internal set; }

        public IList<Photo> Photos { get; internal set; }

        public bool HasPhotos { get; internal set; }

        public string UrlName
        {
            get
            {
                return this.Described
                           ? string.Format("{0}_{1}", this.Genus.Name, this.Name)
                           : string.Format("{0}_sp_{1}", this.Genus.Name, this.Name);
            }
        }
    }
}