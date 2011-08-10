using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Species 
    {
        public int Id { get; set; }

        public string Name { get;  set; }

        public bool Described { get;  set; }

        public Genus Genus { get;  set; }

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

        public bool HaveFish { get;  set; }

        public virtual ICollection<Photo> Photos { get;  set; }

        public bool HasPhotos { get;  set; }

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