using System.Web.Mvc;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class LocalesController : Controller
    {
         private readonly ILocaleIndexPageViewModelFactory _localeIndexPageViewModelFactory;
         private readonly ILocalesRepository _localesRepository;
         private readonly ILocaleUpdatePageViewModelFactory _localeUpdatePageViewModelFactory;

         public LocalesController(ILocaleIndexPageViewModelFactory localeIndexPageViewModelFactory, ILocalesRepository localesRepository, ILocaleUpdatePageViewModelFactory localeUpdatePageViewModelFactory)
        {
            _localeIndexPageViewModelFactory = localeIndexPageViewModelFactory;
            _localesRepository = localesRepository;
            _localeUpdatePageViewModelFactory = localeUpdatePageViewModelFactory;
        }

         public ActionResult Index()
        {
            return View(this._localeIndexPageViewModelFactory.Build());
        }

         public ActionResult Create()
         {
             return View(new NavigationPartialViewModel { SelectedView = SelectedView.Locales });
         }

         [AcceptVerbs(HttpVerbs.Post)]
         public ActionResult Create(LocaleUpdateFormViewModel viewModel)
         {
             TryUpdateModel(viewModel);

             var result = this._localesRepository.Add(viewModel.Name, viewModel.Latitude, viewModel.Longitude);

             return new JsonResult { Data = result };
         }

        public ActionResult Update(int id)
        {
            return View(this._localeUpdatePageViewModelFactory.Build(id));
        }

         [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(LocaleUpdateFormViewModel vm)
        {
            TryUpdateModel(vm);

             var result = this._localesRepository.Update(vm.Id, vm.Name, vm.Latitude, vm.Longitude);

             return result == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

         public ActionResult Delete(int id)
         {
             this._localesRepository.Delete(id);

             return RedirectToAction("Index");
         }
    }
}