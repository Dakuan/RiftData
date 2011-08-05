namespace RiftData.Domain.Entities
{
    public class Photo : EntityBase
    {
        public Photo(int id) : base(id)
        {
        }

        public string FlickrId { get; internal set; }

        public string SquareThumbnail { get; internal set; }

        public string ThumbNailUrl { get; internal set; }

        public string MediumUrl { get; internal set; }

        public string Caption { get; internal set; }
    }
}