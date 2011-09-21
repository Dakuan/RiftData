namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LocalePages;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class LocalesController : Controller
    {
        private readonly ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory;

        private readonly ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        public LocalesController(ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory, ILocalesRepository localesRepository, ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory)
        {
            this.localeIndexPageViewModelFactory = localeIndexPageViewModelFactory;
            this.localesRepository = localesRepository;
            this.localeUpdatePageViewModelFactory = localeUpdatePageViewModelFactory;
        }

        public ActionResult Create()
        {
            return this.View(new NavigationPartialViewModel { SelectedView = SelectedView.Locales });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(LocaleUpdateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var result = this.localesRepository.Add(viewModel.Name, viewModel.Latitude, viewModel.Longitude, this.User.Identity.Name);

            return new JsonResult { Data = result };
        }

        public ActionResult Delete(int id)
        {
            this.localesRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult Index()
        {
            return this.View(this.localeIndexPageViewModelFactory.Build());
        }

        public ActionResult Update(int id)
        {
            return this.View(this.localeUpdatePageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(LocaleUpdateFormViewModel vm)
        {
            this.TryUpdateModel(vm);

            var result = this.localesRepository.Update(vm.Id, vm.Name, vm.Latitude, vm.Longitude, this.User.Identity.Name);

            return result == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }
    }
}