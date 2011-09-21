namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.SpeciesPages;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class SpeciesController : Controller
    {
        private readonly ISpeciesEditPageViewModelFactory speciesEditPageViewModelFactory;

        private readonly ISpeciesPageViewModelFactory speciesPageViewModelFactory;

        private readonly ISpeciesRepository speciesRepository;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory, ISpeciesEditPageViewModelFactory speciesEditPageViewModelFactory, ISpeciesRepository speciesRepository)
        {
            this.speciesPageViewModelFactory = speciesPageViewModelFactory;
            this.speciesEditPageViewModelFactory = speciesEditPageViewModelFactory;
            this.speciesRepository = speciesRepository;
        }

        public ActionResult Create()
        {
            return this.View("Update", this.speciesEditPageViewModelFactory.Build());
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(SpeciesEditFormViewModel vm)
        {
            // TryUpdateModel(vm);
            var addResult = this.speciesRepository.Add(vm.Name, vm.Genus, vm.Described, vm.Description, vm.Size[0], vm.Size[1], vm.Temperament, this.User.Identity.Name);

            return addResult == AddResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this.speciesRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult Index()
        {
            return this.View(this.speciesPageViewModelFactory.Build());
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id)
        {
            return this.View(this.speciesEditPageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(SpeciesEditFormViewModel vm)
        {
            // TryUpdateModel(vm);
            var updateResult = this.speciesRepository.Update(vm.Id, vm.Name, vm.Genus, vm.Described, vm.Description, vm.Size[0], vm.Size[1], vm.Temperament, this.User.Identity.Name);

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }
    }
}