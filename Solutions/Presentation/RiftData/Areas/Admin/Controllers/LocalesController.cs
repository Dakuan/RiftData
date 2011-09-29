using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class LocalesController : Controller
    {
        private readonly ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory;

        private readonly ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory;
        private readonly IGenusRepository genusRepository;

        private readonly ILocalesRepository localesRepository;

        public LocalesController(ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory, ILocalesRepository localesRepository, ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory, IGenusRepository genusRepository)
        {
            this.localeIndexPageViewModelFactory = localeIndexPageViewModelFactory;
            this.localesRepository = localesRepository;
            this.localeUpdatePageViewModelFactory = localeUpdatePageViewModelFactory;
            this.genusRepository = genusRepository;
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

        public ActionResult GetForLakeFromGenus(int id)
        {
            var genus = this.genusRepository.Get(id);

            return RedirectToAction("GetForLake", new { id = genus.GenusType.Lake.Id });
        }

        public ActionResult GetForLake(int id)
        {
            var data = this.localesRepository.GetByLake(id).ToSelectList();

            return new JsonResult
            {
                Data = data,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
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