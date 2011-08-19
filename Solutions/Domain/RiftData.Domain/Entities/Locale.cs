namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class Locale : IDescribable
    {
        public int Id { get; set; }

        public double Latitude { get;  set;  }

        public double Longitude { get;  set; }

        public string Name { get;  set; }

        public virtual ICollection<Photo> Photos { get;  set; }

        public int ZoomLevel { get; set; }

        public bool HasPhotos { get;  set; }

        public virtual Lake Lake { get; set; }

        public string Description { get; set; }

        public bool HasDescription
        {
            get { return !string.IsNullOrEmpty(this.Description); }
        }
    }
}