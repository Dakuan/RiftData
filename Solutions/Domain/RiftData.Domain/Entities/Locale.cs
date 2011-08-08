using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Locale : EntityBase, IPhotoSubject
    {
        public Locale(int id) : base(id)
        {
        }

        public double Latitude { get; internal set;  }

        public double Longitude { get; internal set; }

        public string Name { get; internal set; }

        public IList<Photo> Photos { get; internal set; }

        public bool HasPhotos { get; internal set; }
    }
}