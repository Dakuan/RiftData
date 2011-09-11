namespace RiftData.Domain.Entities
{
    public class Species 
    {
        public int Id { get; set; }

        public string Name { get;  set; }

        public bool Described { get;  set; }

        public virtual Genus Genus { get; set; }

        public virtual Temperament Temperament { get; set; }

        public int MaxSize { get; set; }

        public int MinSize { get; set; }

        public string FullName
        {
            get
            {
                return this.Described
                           ? string.Format("{0} {1}", this.Genus.Name, this.Name)
                           : string.Format(@"{0} sp ""{1}""", this.Genus.Name, this.Name);
            }
        }

        public bool HasFish { get;  set; }

        public bool HasPhotos { get;  set; }

        public string UrlName
        {
            get
            {
                return this.Described
                           ? string.Format("{0}_{1}", this.Genus.Name, this.Name)
                           : string.Format("{0}_sp_{1}", this.Genus.Name, this.Name);
            }
        }

        public string Description { get; set; }

        public bool HasDescription
        {
            get { return !string.IsNullOrEmpty(this.Description); }
        }
    }
}