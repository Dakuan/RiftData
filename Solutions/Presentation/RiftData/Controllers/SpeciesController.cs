using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;

namespace RiftData.Controllers
{
    public class SpeciesController : Controller
    {
        private readonly ISpeciesPageViewModelFactory _speciesPageViewModelFactory;

        public SpeciesController(ISpeciesPageViewModelFactory speciesPageViewModelFactory)
        {
            _speciesPageViewModelFactory = speciesPageViewModelFactory;
        }

        public ActionResult Index(string speciesFullName)
        {
            var viewModel = this._speciesPageViewModelFactory.Build(speciesFullName);

            return View(viewModel);
        }
    }
}