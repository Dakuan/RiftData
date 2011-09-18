using System.Web.Mvc;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class SpeciesController : Controller
    {
         private readonly ISpeciesPageViewModelFactory _speciesPageViewModelFactory;
         private readonly ISpeciesEditPageViewModelFactory _speciesEditPageViewModelFactory;
         private readonly ISpeciesRepository _speciesRepository;

         public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory, ISpeciesEditPageViewModelFactory speciesEditPageViewModelFactory, ISpeciesRepository speciesRepository)
        {
            _speciesPageViewModelFactory = speciesPageViewModelFactory;
            _speciesEditPageViewModelFactory = speciesEditPageViewModelFactory;
             _speciesRepository = speciesRepository;
        }

         public ActionResult Index()
        {
            return View(this._speciesPageViewModelFactory.Build());
        }

        public ActionResult Create()
        {
            return View("Update", this._speciesEditPageViewModelFactory.Build());
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(SpeciesEditFormViewModel vm)
        {
            //TryUpdateModel(vm);

            var addResult = this._speciesRepository.AddSpecies(vm.Name, vm.Genus, vm.Described, vm.Description, vm.Size[0], vm.Size[1], vm.Temperament);

            return addResult == AddResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Update(int id)
        {
            return View(this._speciesEditPageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(SpeciesEditFormViewModel vm)
        {
            //TryUpdateModel(vm);

            var updateResult = this._speciesRepository.Update(vm.Id, vm.Name, vm.Genus, vm.Described, vm.Description, vm.Size[0], vm.Size[1], vm.Temperament);

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this._speciesRepository.DeleteSpecies(id);

            return RedirectToAction("Index");
        }
    }
}