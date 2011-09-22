using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    public class SpeciesIndexPageViewModel : Shared.ViewModelBase
    {
        public SpeciesDto Species { get; set; }

        public IList<LocaleDto> Locales { get; set; }
    }
}