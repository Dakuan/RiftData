namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    public class InfoController : Controller
    {
        private readonly IInfoPageViewModelFactory infoPageViewModelFactory;

        public InfoController(IInfoPageViewModelFactory infoPageViewModelFactory)
        {
            this.infoPageViewModelFactory = infoPageViewModelFactory;
        }

        public ActionResult About()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            return View(viewModel);
        }

        public ActionResult HelpUs()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            return View(viewModel);
        }
    }
}