using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Locale 
    {
        public int Id { get; set; }

        public double Latitude { get;  set;  }

        public double Longitude { get;  set; }

        public string Name { get;  set; }

        public virtual ICollection<Photo> Photos { get;  set; }

        public int ZoomLevel { get; set; }

        public bool HasPhotos { get;  set; }
    }
}