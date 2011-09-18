using System.Web.Mvc;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class GenusController : Controller
    {
        private readonly IGenusIndexPageViewModelFactory _genusIndexPageViewModelFactory;
        private readonly IGenusRepository _genusRepository;
        private readonly IGenusUpdatePageViewModelFactory _genusUpdatePageViewModelFactory;

        public GenusController(IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory, IGenusRepository genusRepository, IGenusUpdatePageViewModelFactory genusUpdatePageViewModelFactory)
        {
            _genusIndexPageViewModelFactory = genusIndexPageViewModelFactory;
            _genusRepository = genusRepository;
            _genusUpdatePageViewModelFactory = genusUpdatePageViewModelFactory;
        }

        public ActionResult Index()
        {
            return View(this._genusIndexPageViewModelFactory.Builld());
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create()
        {
            var viewModel = new GenusUpdatePageViewModel { Id = 0, Mode = "Create"};

            return View("Update", viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GenusUpdateFormViewModel viewModel)
        {
            TryUpdateModel(viewModel);

            var addResult = this._genusRepository.Add(viewModel.Name);

            return addResult == AddResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }
        
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id)
        {
            return View(this._genusUpdatePageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(GenusUpdateFormViewModel viewModel)
        {
            TryUpdateModel(viewModel);

            var updateResult = this._genusRepository.Update(viewModel.Id, viewModel.Name);

            return updateResult == UpdateResult.Success ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this._genusRepository.Delete(id);

            return RedirectToAction("Index");
        }
    }
}