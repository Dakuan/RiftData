using System.Web.Mvc;

namespace RiftData.Presentation.ViewModels.Admin.Species
{
    public class SpeciesEditPageViewModel : Shared.ViewModelBase
    {
        public bool Described { get; set; }

        public string Description { get; set; }

        public SelectList Genus { get; set; }

        public int MaxSize { get; set; }

        public int MinSize { get; set; }

        public string Mode { get; set; }

        public string Name { get; set; }

        public SelectList Temperament { get; set; }
    }
}