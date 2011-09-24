namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class Locale : IDescribable, IEntity
    {
        public string Description { get; set; }

        public bool HasDescription
        {
            get
            {
                return !string.IsNullOrEmpty(this.Description);
            }
        }

        public bool HasPhotos { get; set; }

        public int Id { get; set; }

        public virtual Lake Lake { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public string Name { get; set; }

        public virtual ICollection<Photo> Photos { get; set; }

        public int ZoomLevel { get; set; }

        public static int GetDataZoomFromMapZoom(int mapZoom)
        {
            if (mapZoom <= 8)
            {
                return 1;
            }

            if (mapZoom == 9)
            {
                return 2;
            }

            if (mapZoom > 9 && mapZoom <= 11)
            {
                return 3;
            }

            if (mapZoom > 11)
            {
                return 4;
            }

            return 1;
        }
    }
}