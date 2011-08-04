namespace RiftData.Domain.Entities
{
    public class Photo : EntityBase
    {
        public Photo(int id) : base(id)
        {
        }

        public string FlickrId { get; set; }

        public string ThumbNailUrl { get; set; }

        public string MediumUrl { get; set; }

        public string Caption { get; set; }
    }
}