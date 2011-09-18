using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class LocalePageViewModel : ViewModelBase
    {
        public LocalePageViewModel()
        {
            SelectedView = SelectedView.Locales;
        }

        public List<Locale> Locales { get; set; }

        public SelectList LocalesSelectList { get; set; }
    }
}