namespace RiftData.Presentation.ViewModels.Mobile
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class SpeciesIndexPageViewModel : Shared.ViewModelBase
    {
        public SpeciesDto Species { get; set; }

        public IList<LocaleDto> Locales { get; set; }

        public IList<PhotoDto> Photos { get; set; } 
    }
}