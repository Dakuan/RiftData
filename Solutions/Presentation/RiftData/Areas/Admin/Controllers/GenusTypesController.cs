namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.Contracts.Admin.GenusTypePages;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class GenusTypesController : Controller
    {
        private readonly IGenusTypeCreatePageViewModelFactory genusTypeCreatePageViewModelFactory;

        private readonly IGenusTypeIndexPageViewModelFactory genusTypeIndexPageViewModelFactory;

        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly IGenusTypesUpdatePageViewModelFactory genusTypesUpdatePageViewModelFactory;

        public GenusTypesController(
            IGenusTypeIndexPageViewModelFactory genusTypeIndexPageViewModelFactory, 
            IGenusTypesUpdatePageViewModelFactory genusTypesUpdatePageViewModelFactory, 
            IGenusTypeRepository genusTypeRepository, 
            IGenusTypeCreatePageViewModelFactory genusTypeCreatePageViewModelFactory)
        {
            this.genusTypeIndexPageViewModelFactory = genusTypeIndexPageViewModelFactory;
            this.genusTypesUpdatePageViewModelFactory = genusTypesUpdatePageViewModelFactory;
            this.genusTypeRepository = genusTypeRepository;
            this.genusTypeCreatePageViewModelFactory = genusTypeCreatePageViewModelFactory;
        }

        public ActionResult Create()
        {
            return this.View(this.genusTypeCreatePageViewModelFactory.Build());
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GenusTypeCreateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var result = this.genusTypeRepository.Add(viewModel.Name, viewModel.Lake, this.User.Identity.Name);

            return new JsonResult { Data = result == AddResult.Success };
        }

        public ActionResult Delete(int id)
        {
            this.genusTypeRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult Index()
        {
            return this.View(this.genusTypeIndexPageViewModelFactory.Build());
        }

        public ActionResult Update(int id)
        {
            return this.View(this.genusTypesUpdatePageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(GenusTypeUpdateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var result = this.genusTypeRepository.Update(viewModel.Id, viewModel.Name, viewModel.Lake, this.User.Identity.Name);

            return new JsonResult { Data = result == UpdateResult.Success };
        }
    }
}