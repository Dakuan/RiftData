using System;
using System.Web.Mvc;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class FishController : Controller
    {
        private readonly IFishPageViewModelFactory _fishPageViewModelFactory;
        private readonly IFishEditPageViewModelFactory _fishEditPageViewModelFactory;
        private readonly IFishRepository _fishRepository;
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IPhotosRepository _photosRepository;

        public FishController(IFishPageViewModelFactory fishPageViewModelFactory, IFishEditPageViewModelFactory fishEditPageViewModelFactory, IFishRepository fishRepository, ISpeciesRepository speciesRepository, IPhotosRepository photosRepository)
        {
            _fishPageViewModelFactory = fishPageViewModelFactory;
            _fishEditPageViewModelFactory = fishEditPageViewModelFactory;
            _fishRepository = fishRepository;
            _speciesRepository = speciesRepository;
            _photosRepository = photosRepository;
        }

        public ActionResult Index(int? id)
        {
            if (id == null)
            {
                id = 1;
            }

            var viewModel = _fishPageViewModelFactory.Build(Convert.ToInt16(id));

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create(bool? showSuccessMessage)
        {
            var vm = this._fishEditPageViewModelFactory.Build(0, Convert.ToBoolean(showSuccessMessage));

            return View(vm);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(FishEditFormViewModel viewModel)
        {
            TryUpdateModel(viewModel);

            var updateResult = _fishRepository.Add(viewModel.Genus, viewModel.Species, viewModel.Locales, viewModel.Description);

            return updateResult == AddResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id, bool? showSuccessMessage)
        {
            var viewModel = this._fishEditPageViewModelFactory.Build(id, Convert.ToBoolean(showSuccessMessage));

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(FishEditFormViewModel vm)
        {
            TryUpdateModel(vm);

            var updateResult = this._fishRepository.Update(vm.Id, vm.Genus, vm.Species, vm.Locales, vm.Description);

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult  { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this._fishRepository.Delete(id);

            return RedirectToAction("Index");
        }

        public ActionResult DeletePhoto(int fishId, int photoId)
        {
            this._photosRepository.Delete(photoId);

            return RedirectToAction("Update", new {id = fishId});
        }

        public ActionResult GetSpecies(int id)
        {
            var speciesList = new SelectList(this._speciesRepository.GetSpeciesWithGenus(id), "Id", "Name");

            return new JsonResult { Data =speciesList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}