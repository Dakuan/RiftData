using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Domain.Entities
{
    public class GenusType
    {
        public int Id { get; set; }

        public string Name { get;  set; }

        public virtual ICollection<Genus> Genus { get; set; }

        public virtual Lake Lake { get; set; }

        public string Description { get; set; }

        public int NumberOfGenera {get { return this.Genus.Count; }}
    }
}
