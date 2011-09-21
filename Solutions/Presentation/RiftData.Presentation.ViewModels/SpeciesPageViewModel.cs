namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class SpeciesPageViewModel : ViewModelBase, IPanelViewModel
    {
        public IList<FishDto> Fish { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public IEnumerable<LocaleDto> Locales { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }

        public SpeciesDto Species { get; set; }
    }
}