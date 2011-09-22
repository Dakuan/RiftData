namespace RiftData.Presentation.ViewModels.Shared
{
    public class MetaData
    {
        public static MetaData Build(string keywords, string title, string description)
        {
            return new MetaData(keywords, title, description);
        }

        private MetaData(string keywords, string title, string description)
        {
            this.MetaKeywords = keywords;

            this.MetaTitle = title;

            this.MetaDescription = description;
        }

        public string MetaKeywords { get; set; }

        public string MetaTitle { get; set; }

        public string MetaDescription { get; set; }
    }
}