namespace RiftData.Domain.Entities
{
    public class Species : EntityBase
    {
        public Species(int id) : base(id)
        {
        }

        public string Name { get; internal set; }

        public bool Described { get; internal set; }

        public Genus Genus { get; internal set; }

        public override string ToString()
        {
            return this.Name;
        }

        public string GetFullName
        {
            get
            {
                return this.Described
                           ? string.Format("{0} {1}", this.Genus.Name, this.Name)
                           : string.Format(@"{0} sp""{1}""", this.Genus.Name, this.Name);
            }
        }
    }
}