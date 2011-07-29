using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Domain.Core
{
    public class Species : EntityBase
    {
        public Species(int id, string name, bool described) : base(id)
        {
            this.Name = name;
            this.Described = described;
        }

        public string Name { get; private set; }

        public bool Described { get; private set; }

        public Genus Genus { get; set; }

        public override string ToString()
        {
            return this.Name;
        }

        public string GetFullName
        {
            get
            {
                return this.Described
                           ? string.Format("{0} {1}", this.Genus.Name, this.Name)
                           : string.Format(@"{0} sp""{1}""", this.Genus.Name, this.Name);
            }
        }
    }
}