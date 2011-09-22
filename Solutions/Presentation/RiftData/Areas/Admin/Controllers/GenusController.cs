using RiftData.Presentation.Contracts.ViewModelFactories.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.ApplicationServices.ViewModelFactories.Admin;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;
    using RiftData.Presentation.ViewModels.Admin.Genus;

    [Authorize]
    public class GenusController : Controller
    {
        private readonly IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory;

        private readonly IGenusRepository genusRepository;

        private readonly IGenusUpdatePageViewModelFactory genusUpdatePageViewModelFactory;

        private readonly IGenusCreatePageViewModelFactory genusCreatePageViewModelFactory;

        public GenusController(IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory, IGenusRepository genusRepository, IGenusUpdatePageViewModelFactory genusUpdatePageViewModelFactory, IGenusCreatePageViewModelFactory genusCreatePageViewModelFactory)
        {
            this.genusIndexPageViewModelFactory = genusIndexPageViewModelFactory;
            this.genusRepository = genusRepository;
            this.genusUpdatePageViewModelFactory = genusUpdatePageViewModelFactory;
            this.genusCreatePageViewModelFactory = genusCreatePageViewModelFactory;
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create()
        {
            var viewModel = this.genusCreatePageViewModelFactory.Build();

            return View("Create", viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GenusCreateFormViewModel viewModel)
        {
            var addResult = this.genusRepository.Add(viewModel.Name, viewModel.GenusType, this.User.Identity.Name);

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

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }
    }
}