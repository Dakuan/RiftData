namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    // [OutputCache(CacheProfile = "Daily")]
    public class SpeciesController : Controller
    {
        private readonly ISpeciesPageViewModelFactory speciesPageViewModelFactory;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory)
        {
            this.speciesPageViewModelFactory = speciesPageViewModelFactory;
        }

        public ActionResult Index(string speciesFullName)
        {
            var viewModel = this.speciesPageViewModelFactory.Build(speciesFullName);

            return View(viewModel);
        }
    }
}