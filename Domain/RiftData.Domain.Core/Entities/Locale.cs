namespace RiftData.Domain.Entities
{
    public class Locale : EntityBase
    {
        public Locale(int id) : base(id)
        {
        }

        public double Latitude { get; internal set;  }

        public double Longitude { get; internal set; }

        public string Name { get; internal set; }
    }
}