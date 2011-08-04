using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.Controllers.Shared
{
    public class SpeciesController : Controller
    {
        private readonly IFishRepository _fishRepository;

        private readonly ISpeciesRepository _speciesRepository;

        private readonly IDtoFactory _dtoFactory;

        public SpeciesController(IFishRepository fishRepository, ISpeciesRepository speciesRepository, IDtoFactory dtoFactory)
        {
            _fishRepository = fishRepository;
            _speciesRepository = speciesRepository;
            _dtoFactory = dtoFactory;
        }

        public ActionResult Index(string speciesFullName)
        {
            int speciesId;

            var result = new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet };

            try
            {
                speciesId = this._speciesRepository.FindSpeciesIdFromFullName(speciesFullName);
            }
            catch (Exception)
            {
                result.Data = string.Format("no species called {0} found in database", speciesFullName);

                return result;
            }

            var fishList = this._fishRepository.GetFishBySpecies(speciesId).ToList();

            if (fishList.Count > 0)
            {
                var list = new List<FishDto>();

                fishList.ForEach(f => list.Add(this._dtoFactory.Build(f)));

                result.Data = list;
            }
            else
            {
                result.Data = "no fish found";
            }

            return result;
        }
    }
}
