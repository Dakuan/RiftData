using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories;

namespace RiftData.Controllers
{
    using System.Linq;
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class InfoController : Controller
    {
        private readonly IHelpPageViewModelFactory _helpPageViewModelFactory;
        private readonly IInfoPageViewModelFactory infoPageViewModelFactory;
        private readonly ILakeRepository lakeRepository;

        private readonly IGenusTypeRepository genusTypeRepository;

        public InfoController(IHelpPageViewModelFactory helpPageViewModelFactory, IInfoPageViewModelFactory infoPageViewModelFactory, ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            _helpPageViewModelFactory = helpPageViewModelFactory;
            this.infoPageViewModelFactory = infoPageViewModelFactory;
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public ActionResult About()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            viewModel.Description = "Information about Rift Data";

            viewModel.Keywords = this.AssembleKeywords();

            return View(viewModel);
        }

        public ActionResult Thanks()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            viewModel.Description = "Shout outs to everyone that has helped us";

            viewModel.Keywords = this.AssembleKeywords();

            return View(viewModel);
        }

        public ActionResult HelpUs()
        {
            var viewModel = this._helpPageViewModelFactory.Build();

            viewModel.Description = "Help us improve RiftData";

            viewModel.Keywords = this.AssembleKeywords();

            return View(viewModel);
        }

        private string AssembleKeywords()
        {
            var keywords = string.Format("Rift Valley Cichlids, {0}, {1}", string.Join(", ", this.lakeRepository.GetAll().Select(x => x.Name)), string.Join(", ", this.genusTypeRepository.GetAll().Select(x => x.Name)));

            return keywords;
        }
    }
}