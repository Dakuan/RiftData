using System.Web;
using RiftData.ApplicationServices.Extensions;
using RiftData.Classes;
using RiftData.Domain.Repositories;

namespace RiftData.Controllers
{
    using System.Linq;
    using System.Web.Mvc;

    public class ServiceController : Controller
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly IGenusRepository genusRepository;
        private readonly ILocalesRepository localesRepository;


        public ServiceController(ISpeciesRepository speciesRepository, IGenusRepository genusRepository, ILocalesRepository localesRepository)
        {
            this.speciesRepository = speciesRepository;
            this.genusRepository = genusRepository;
            this.localesRepository = localesRepository;
        }

        public ActionResult GetAllGenera()
        {
            var results = this.genusRepository.GetAll().ToDtoList();

            results.ToList().ForEach(g => g.Species.Clear());

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = results };
        }

        [JsonpFilter]
        public JsonResult GetLocalesForZoomLevel(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.localesRepository.GetForZoomLevel(id) };
        }

        public ActionResult GetSpeciesForGenus(int id)
        {
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.speciesRepository.GetSpeciesWithGenus(id).ToDtoList() };
        }
    }
}