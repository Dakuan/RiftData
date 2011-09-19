using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class LocalePageViewModel : ViewModelBase
    {
        public LocalePageViewModel()
        {
            SelectedView = SelectedView.Locales;
        }

        public IList<LocaleDto> Locales { get; set; }

        public SelectList LocalesSelectList { get; set; }
    }
}