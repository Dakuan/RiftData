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
        private readonly ILocaleCreatePageViewModelFactory localeCreatePageViewModelFactory;
        private readonly ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory;

        private readonly ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory;

        private readonly IGenusRepository genusRepository;

        private readonly INavigationViewModelFactory navigationViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        public LocalesController(ILocaleCreatePageViewModelFactory localeCreatePageViewModelFactory, ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory, ILocalesRepository localesRepository, ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory, IGenusRepository genusRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.localeCreatePageViewModelFactory = localeCreatePageViewModelFactory;
            this.localeIndexPageViewModelFactory = localeIndexPageViewModelFactory;
            this.localesRepository = localesRepository;
            this.localeUpdatePageViewModelFactory = localeUpdatePageViewModelFactory;
            this.genusRepository = genusRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public ActionResult Create()
        {
            var viewModel = this.localeCreatePageViewModelFactory.Build();

            return this.View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(LocaleUpdateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var result = this.localesRepository.Add(viewModel.Lake, viewModel.Name, viewModel.Latitude, viewModel.Longitude, this.User.Identity.Name);

            var data = result == AddResult.Success;

            return new JsonResult { Data = data };
        }

        public ActionResult GetForLakeFromGenus(int id)
        {
            var genus = this.genusRepository.Get(id);

            return RedirectToAction("GetForLake", new { id = genus.GenusType.Lake.Id });
        }

        public JsonResult GetForLake(int id)
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