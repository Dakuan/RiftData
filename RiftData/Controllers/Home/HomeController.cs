using System.Linq;
using System.Web.Mvc;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using Species = RiftData.Domain.Entities.Species;

namespace RiftData.Controllers.Home
{
    public class HomeController : Controller
    {
        private IRepository<Fish> fishRepository;

        public HomeController(IRepository<Fish> fishRepository)
        {
            this.fishRepository = fishRepository;
        }

        public ActionResult Index()
        {
            var viewModel = new HomeViewModel();

            this.fishRepository.List.ToList().ForEach(s => viewModel.Items.Add(s.FullName));

            return View(viewModel);
        }
    }
}
