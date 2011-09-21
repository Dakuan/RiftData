namespace RiftData.Domain.Entities
{
    using System.Collections.Generic;

    public class Fish : IEntity, IPhotoSubject
    {
        public string Description { get; set; }

        public virtual Genus Genus { get; set; }

        public bool HasDescription
        {
            get
            {
                return !string.IsNullOrEmpty(this.Description);
            }
        }

        public bool HasPhotos
        {
            get
            {
                return this.Photos.Count > 0;
            }
        }

        public int Id { get; set; }

        public virtual Locale Locale { get; set; }

        public string Name
        {
            get
            {
                return this.Species.Described ? string.Format("{0} {1} '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name) : string.Format(@"{0} sp ""{1}"" '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name);
            }
        }

        public virtual ICollection<Photo> Photos { get; set; }

        public virtual Species Species { get; set; }

        public string UrlName
        {
            get
            {
                return string.Format("{0}_{1}_{2}", this.Genus.Name, this.Species.Name, this.Locale.Name);
            }
        }

        public static string GetFullName(string genusName, string speciesName, string localeName, bool described)
        {
            return described ? string.Format("{0} {1} '{2}'", genusName, speciesName, localeName) : string.Format(@"{0} sp ""{1}"" '{2}'", genusName, speciesName, localeName);
        }
    }
}