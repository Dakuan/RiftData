using System;
using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public class Fish
    {
        public int Id { get; set; }

        public Genus Genus { get; set; }

        public Species Species { get; set; }

        public Locale Locale { get; set; }

        public String Name
        {
            get
            {
                return this.Species.Described
                           ? string.Format("{0} {1} '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name)
                           : string.Format(@"{0} sp ""{1}"" '{2}'", this.Genus.Name, this.Species.Name, this.Locale.Name);
            }
        }

        public String UrlName
        {
            get { return string.Format("{0}_{1}_{2}", this.Genus.Name, this.Species.Name, this.Locale.Name); }
        }

        public bool HasPhotos { get; set; }

        public static string GetFullName(string genusName, string speciesName, string localeName, bool described)
        {
            return described
                       ? string.Format("{0} {1} '{2}'", genusName, speciesName, localeName)
                       : string.Format(@"{0} sp ""{1}"" '{2}'", genusName, speciesName, localeName);
        }
    }
}
