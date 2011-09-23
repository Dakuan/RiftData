namespace RiftData.Presentation.ViewModels.Shared
{
    public class MetaData
    {
        private MetaData(string keywords, string title, string description)
        {
            this.MetaKeywords = keywords;

            this.MetaTitle = title;

            this.MetaDescription = description;
        }

        public string MetaKeywords { get; set; }

        public string MetaTitle { get; set; }

        public string MetaDescription { get; set; }

        public static MetaData Build(string keywords, string title, string description)
        {
            return new MetaData(keywords, string.Format("RiftData | {0}", title), description);
        }
    }
}