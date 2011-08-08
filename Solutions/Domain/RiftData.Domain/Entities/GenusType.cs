using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Domain.Entities
{
    public class GenusType : EntityBase
    {
        public GenusType(int id) : base(id)
        {
        }

        public string Name { get; internal set; }

        public int GenusCount { get; internal set; }
    }
}
