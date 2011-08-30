using System.Web.Mvc;

namespace RiftData.Controllers
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;

    public class ServiceController : Controller
    {
        private readonly IGenusDtoService genusDtoService;

        private readonly ISpeciesDtoService speciesDtoService;

        public ServiceController(IGenusDtoService genusDtoService, ISpeciesDtoService speciesDtoService)
        {
            this.genusDtoService = genusDtoService;
            this.speciesDtoService = speciesDtoService;
        }

        public ActionResult GetAllGenera()
        {
            var results = this.genusDtoService.GetGenusDtos();

            results.ToList().ForEach(g => g.Species.Clear());

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = results };
        }

        public ActionResult GetSpeciesForGenus(int id)
        {
            return new JsonResult
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = this.speciesDtoService.GetSpeciesWithGenus(id)
                };
        }
    }
}
