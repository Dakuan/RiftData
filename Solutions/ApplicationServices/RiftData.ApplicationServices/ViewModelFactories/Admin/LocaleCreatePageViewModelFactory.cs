using System.Web.Mvc;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Locale;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class LocaleCreatePageViewModelFactory : ILocaleCreatePageViewModelFactory
    {
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        private readonly ILakeRepository lakeRepository;

        public LocaleCreatePageViewModelFactory(INavigationViewModelFactory navigationViewModelFactory, ILakeRepository lakeRepository)
        {
            this.navigationViewModelFactory = navigationViewModelFactory;
            this.lakeRepository = lakeRepository;
        }

        public LocaleCreatePageViewModel Build()
        {
            var viewModel = new LocaleCreatePageViewModel
                                {
                                    NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Locales),
                                    Lakes = new SelectList(this.lakeRepository.GetAll(), "Id", "Name")
                                };

            return viewModel;
        }
    }
}
