namespace RiftData.Presentation.ViewModels.Admin
{
    public class SpeciesEditFormViewModel
    {
        public bool Described { get; set; }

        public string Description { get; set; }

        public int Genus { get; set; }

        public int Id { get; set; }

        public string Name { get; set; }

        public int[] Size { get; set; }

        public int Temperament { get; set; }
    }
}