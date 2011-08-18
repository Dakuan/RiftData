using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Domain.Entities
{
    public class Lake
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public virtual ICollection<GenusType> GenusTypes { get; set; }
    }
}
