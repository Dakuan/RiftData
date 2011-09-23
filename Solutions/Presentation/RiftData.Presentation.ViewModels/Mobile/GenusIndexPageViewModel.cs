namespace RiftData.Presentation.ViewModels.Mobile
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusIndexPageViewModel : Shared.ViewModelBase
    {
        public IDictionary<SpeciesDto, PhotoDto> SpeciesList { get; set; }
    }
}