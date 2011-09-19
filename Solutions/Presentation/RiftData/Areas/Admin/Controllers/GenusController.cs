namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class GenusController : Controller
    {
        private readonly IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory;

        private readonly IGenusRepository genusRepository;

        private readonly IGenusUpdatePageViewModelFactory genusUpdatePageViewModelFactory;

        public GenusController(
            IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory, 
            IGenusRepository genusRepository, 
            IGenusUpdatePageViewModelFactory genusUpdatePageViewModelFactory)
        {
            this.genusIndexPageViewModelFactory = genusIndexPageViewModelFactory;
            this.genusRepository = genusRepository;
            this.genusUpdatePageViewModelFactory = genusUpdatePageViewModelFactory;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create()
        {
            var viewModel = new GenusUpdatePageViewModel { Id = 0, Mode = "Create" };

            return View("Update", viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GenusUpdateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var addResult = this.genusRepository.Add(viewModel.Name);

            return addResult == AddResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this.genusRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult Index()
        {
            return this.View(this.genusIndexPageViewModelFactory.Builld());
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id)
        {
            return this.View(this.genusUpdatePageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(GenusUpdateFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var updateResult = this.genusRepository.Update(viewModel.Id, viewModel.Name);

            return updateResult == UpdateResult.Success
                       ? new JsonResult { Data = true }
                       : new JsonResult { Data = false };
        }
    }
}