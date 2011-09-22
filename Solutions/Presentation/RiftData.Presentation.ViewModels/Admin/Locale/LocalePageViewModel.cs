using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Locale
{
    public class LocalePageViewModel : Shared.ViewModelBase
    {
        public LocalePageViewModel()
        {
            this.SelectedView = SelectedView.Locales;
        }

        public IList<LocaleDto> Locales { get; set; }

        public SelectList LocalesSelectList { get; set; }
    }
}