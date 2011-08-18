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

        public int GenusCount { get;  set; }

        public virtual ICollection<Genus> Genus { get; set; }

        public virtual Lake Lake { get; set; }
    }
}
