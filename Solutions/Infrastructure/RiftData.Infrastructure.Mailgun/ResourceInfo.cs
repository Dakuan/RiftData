namespace RiftData.Infrastructure.Mailgun
{
    internal struct ResourceInfo
    {
        public string collectionName;

        public string elementName;

        public ResourceInfo(string collectionName, string elementName)
        {
            this.collectionName = collectionName;
            this.elementName = elementName;
        }
    }
}