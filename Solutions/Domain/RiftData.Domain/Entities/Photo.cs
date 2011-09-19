namespace RiftData.Domain.Entities
{
    public class Photo
    {
        public string Caption { get; set; }

        public string FlickrId { get; set; }

        public int Id { get; set; }

        public string LargeUrl { get; set; }

        public string MediumUrl { get; set; }

        public string SmallUrl { get; set; }

        public string SquareThumbnail { get; set; }

        public string ThumbNailUrl { get; set; }
    }
}