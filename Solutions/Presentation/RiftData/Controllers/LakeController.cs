using System.Web.Mvc;
using RiftData.Presentation.Contracts;

namespace RiftData.Controllers
{
    public class LakeController : Controller
    {
        private readonly ILakeViewModelFactory _lakeViewModelFactory;

        public LakeController(ILakeViewModelFactory lakeViewModelFactory)
        {
            _lakeViewModelFactory = lakeViewModelFactory;
        }

        public ActionResult Index(string lakeName)
        {
            return View(this._lakeViewModelFactory.Build(lakeName));
        }
    }
}