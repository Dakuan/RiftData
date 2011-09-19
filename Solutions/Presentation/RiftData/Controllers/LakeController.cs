namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    public class LakeController : Controller
    {
        private readonly ILakeViewModelFactory lakeViewModelFactory;

        public LakeController(ILakeViewModelFactory lakeViewModelFactory)
        {
            this.lakeViewModelFactory = lakeViewModelFactory;
        }

        public ActionResult Index(string lakeName)
        {
            return this.View(this.lakeViewModelFactory.Build(lakeName));
        }
    }
}