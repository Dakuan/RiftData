namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    // [OutputCache(CacheProfile = "Daily")]
    public class SpeciesController : Controller
    {
        private readonly ISpeciesPageViewModelFactory _speciesPageViewModelFactory;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory)
        {
            this._speciesPageViewModelFactory = speciesPageViewModelFactory;
        }

        public ActionResult Index(string speciesFullName)
        {
            var viewModel = this._speciesPageViewModelFactory.Build(speciesFullName);

            return View(viewModel);
        }
    }
}