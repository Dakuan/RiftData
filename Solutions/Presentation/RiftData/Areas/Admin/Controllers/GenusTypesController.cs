using System.Web.Mvc;
using RiftData.Domain.Enums;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class GenusTypesController : Controller
    {
        private readonly IGenusTypeIndexPageViewModelFactory _genusTypeIndexPageViewModelFactory;
        private readonly IGenusTypesUpdatePageViewModelFactory _genusTypesUpdatePageViewModelFactory;
        private readonly IGenusTypeRepository _genusTypeRepository;
        private readonly IGenusTypeCreatePageViewModelFactory _genusTypeCreatePageViewModelFactory;

        public GenusTypesController(IGenusTypeIndexPageViewModelFactory genusTypeIndexPageViewModelFactory, IGenusTypesUpdatePageViewModelFactory genusTypesUpdatePageViewModelFactory, IGenusTypeRepository genusTypeRepository, IGenusTypeCreatePageViewModelFactory genusTypeCreatePageViewModelFactory)
        {
            _genusTypeIndexPageViewModelFactory = genusTypeIndexPageViewModelFactory;
            _genusTypesUpdatePageViewModelFactory = genusTypesUpdatePageViewModelFactory;
            _genusTypeRepository = genusTypeRepository;
            _genusTypeCreatePageViewModelFactory = genusTypeCreatePageViewModelFactory;
        }

        public ActionResult Index()
        {
            return View(this._genusTypeIndexPageViewModelFactory.Build());
        }

        public ActionResult Create()
        {
            return View(this._genusTypeCreatePageViewModelFactory.Build());
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GenusTypeCreateFormViewModel viewModel)
        {
            TryUpdateModel(viewModel);

            var result = this._genusTypeRepository.Add(viewModel.Name, viewModel.Lake);

            return new JsonResult
                {
                    Data = result == AddResult.Success ? true : false
                };
        }

        public ActionResult Update(int id)
        {
            return View(this._genusTypesUpdatePageViewModelFactory.Build(id));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(GenusTypeUpdateFormViewModel viewModel)
        {
            TryUpdateModel(viewModel);

            var result = this._genusTypeRepository.Update(viewModel.Id, viewModel.Name, viewModel.Lake);

            return new JsonResult
                       {
                           Data = result == UpdateResult.Success ? true : false
                       };
        }

        public ActionResult Delete(int id)
        {
            this._genusTypeRepository.Delete(id);

            return RedirectToAction("Index");
        }
    }
}