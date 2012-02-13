using System.Linq;
using System.Web.Mvc;
using RiftData.Classes;
using RiftData.Domain.Repositories;

namespace RiftData.Controllers
{
    using System;

    using RiftData.Extensions;

    public class JsClientController : Controller
    {
        private readonly IGenusRepository _genusRepository;
        private readonly ISpeciesRepository _speciesRepository;
        private readonly ILocalesRepository _localesRepository;

        public JsClientController(IGenusRepository genusRepository, ISpeciesRepository speciesRepository, ILocalesRepository localesRepository)
        {
            _genusRepository = genusRepository;
            _speciesRepository = speciesRepository;
            _localesRepository = localesRepository;
        }

        [HttpGet]
        [JsonpFilter]
        public JsonResult GetGeneraForLake(int id)
        {
            var genus = this._genusRepository.GetForLake(id);

            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = this._genusRepository.GetForLake(id).Where(g => g.Species.Any(s => s.HasFish)).Select(x =>new
                                                                                  {
                                                                                    id = x.Id,
                                                                                    name = x.Name
                                                                                  })
                       };
        }

        [HttpGet]
        [JsonpFilter]
        public JsonResult GetSpeciesForGenera(int id)
        {
            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = _speciesRepository.GetSpeciesWithGenus(id).Where(s => s.HasFish).Select(x => new
                                                                                             {
                                                                                               id = x.Id,
                                                                                               name = x.Name
                                                                                             })
                       };
        }

        [HttpGet]
        [JsonpFilter]
        public JsonResult GetLocalesForSpecies(int id)
        {
            return new JsonResult
                       {
                           JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                           Data = _localesRepository.GetWithSpecies(id).Select(x => new
                                                                                        {
                                                                                            id = x.Id,
                                                                                            name = x.Name,
                                                                                            lat = x.Latitude,
                                                                                            lng = x.Longitude,
                                                                                            url = Url.ToPublicUrl(new Uri(Url.Action("index", "locale", new { localeName = x.Name }), UriKind.Relative)),
                                                                                        })
                       };
        }
    }
}
