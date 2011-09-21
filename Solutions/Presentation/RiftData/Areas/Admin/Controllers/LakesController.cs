namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LakePages;
    using RiftData.Presentation.ViewModels.Admin.Lake;

    [Authorize]
    public class LakesController : Controller
    {
        private readonly ILakeIndexPageViewModelFactory lakeIndexPageViewModelFactory;

        private readonly ILakeUpdatePageViewModelFactory lakeUpdatePageViewModelFactory;

        private readonly ILakeRepository lakeRepository;

        public LakesController(ILakeIndexPageViewModelFactory lakeIndexPageViewModelFactory, ILakeUpdatePageViewModelFactory lakeUpdatePageViewModelFactory, ILakeRepository lakeRepository)
        {
            this.lakeIndexPageViewModelFactory = lakeIndexPageViewModelFactory;
            this.lakeUpdatePageViewModelFactory = lakeUpdatePageViewModelFactory;
            this.lakeRepository = lakeRepository;
        }

        public ActionResult Index()
        {
            var viewModel = this.lakeIndexPageViewModelFactory.Build();

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int Id)
        {
            var viewModel = this.lakeUpdatePageViewModelFactory.Build(Id);

            return View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(LakeUpdateFormViewModel viewModel)
        {
            var result = this.lakeRepository.Update(viewModel.Id, viewModel.Description, viewModel.Name, this.User.Identity.Name);

            return new JsonResult { Data = result == UpdateResult.Success, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}