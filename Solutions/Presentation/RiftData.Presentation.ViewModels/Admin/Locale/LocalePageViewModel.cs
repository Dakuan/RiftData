namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Dto;

    public class LocalePageViewModel : ViewModelBase
    {
        public LocalePageViewModel()
        {
            this.SelectedView = SelectedView.Locales;
        }

        public IList<LocaleDto> Locales { get; set; }

        public SelectList LocalesSelectList { get; set; }
    }
}