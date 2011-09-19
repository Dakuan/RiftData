using System.Linq;
using System.Web.Mvc;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class LocaleIndexPageViewModelFactory : ILocaleIndexPageViewModelFactory
    {
        private readonly ILocalesRepository _localesRepository;

        public LocaleIndexPageViewModelFactory(ILocalesRepository localesRepository)
        {
            _localesRepository = localesRepository;
        }

        public LocalePageViewModel Build()
        {
            var locales = this._localesRepository.GetAll();

            var viewModel = new LocalePageViewModel
                                {
                                    Locales = locales.ToList().ToDtoList(),
                                    LocalesSelectList = new SelectList(locales, "Id", "Name")
                                };

            return viewModel;
        }
    }
}