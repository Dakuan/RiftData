namespace RiftData.Controllers
{
    using System.Linq;
    using System.Web.Mvc;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Presentation.Contracts;

    public class InfoController : Controller
    {
        private readonly IGenusTypeDtoService genusTypeDtoService;

        private readonly IInfoPageViewModelFactory infoPageViewModelFactory;

        private readonly ILakeDtoService lakeDtoService;

        public InfoController(IInfoPageViewModelFactory infoPageViewModelFactory, ILakeDtoService lakeDtoService, IGenusTypeDtoService genusTypeDtoService)
        {
            this.infoPageViewModelFactory = infoPageViewModelFactory;
            this.genusTypeDtoService = genusTypeDtoService;
            this.lakeDtoService = lakeDtoService;
        }

        public ActionResult About()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            viewModel.Description = "Information about Rift Data";

            viewModel.Keywords = this.AssembleKeywords();

            return View(viewModel);
        }

        public ActionResult HelpUs()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            viewModel.Description = "Help us improve RiftData";

            viewModel.Keywords = this.AssembleKeywords();

            return View(viewModel);
        }

        private string AssembleKeywords()
        {
            var keywords = string.Format("Rift Valley Cichlids, {0}, {1}", string.Join(", ", this.lakeDtoService.GetAllLakes().Select(x => x.Name)), string.Join(", ", this.genusTypeDtoService.GetAllGenusTypes().Select(x => x.Name)));

            return keywords;
        }
    }
}