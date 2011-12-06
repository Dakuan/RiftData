using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.Areas.Admin.Controllers
{
    using System;
    using System.Web.Mvc;
    using System.Web.Routing;

    using RiftData.Domain.Entities;
    using RiftData.Extensions;
    using RiftData.ApplicationServices.Twitter;
    using RiftData.Domain.Enums;
    using RiftData.Domain.Repositories;
    using RiftData.Infrastructure.Data.Logging;
    using RiftData.Presentation.ViewModels.Admin;

    using UrlHelper = RiftData.Classes.UrlHelper;

    [Authorize]
    public class FishController : Controller
    {
        private readonly IFishEditPageViewModelFactory fishEditPageViewModelFactory;

        private readonly ITwitterService twitterService;

        private readonly IFishPageViewModelFactory fishPageViewModelFactory;

        private readonly IFishRepository fishRepository;

        private readonly ILogger logger;

        private readonly IPhotosRepository photosRepository;

        private readonly ISpeciesRepository speciesRepository;

        public FishController(ITwitterService twitterService, IFishPageViewModelFactory fishPageViewModelFactory, IFishEditPageViewModelFactory fishEditPageViewModelFactory, IFishRepository fishRepository, ISpeciesRepository speciesRepository, IPhotosRepository photosRepository, ILogger logger)
        {
            this.twitterService = twitterService;
            this.fishPageViewModelFactory = fishPageViewModelFactory;
            this.fishEditPageViewModelFactory = fishEditPageViewModelFactory;
            this.fishRepository = fishRepository;
            this.speciesRepository = speciesRepository;
            this.photosRepository = photosRepository;
            this.logger = logger;
        }

        public ActionResult Index(int? id)
        {
            if (id == null)
            {
                id = 1;
            }

            var viewModel = this.fishPageViewModelFactory.Build(Convert.ToInt16(id));

            return this.View(viewModel);
        }

        public ActionResult GetSpecies(int id)
        {
            var speciesList = this.speciesRepository.GetSpeciesWithGenus(id).ToSelectList();

            return new JsonResult { Data = speciesList, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Create(bool? showSuccessMessage)
        {
            var vm = this.fishEditPageViewModelFactory.Build(0, Convert.ToBoolean(showSuccessMessage));

            return View(vm);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(FishEditFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var fish = this.fishRepository.Add(viewModel.Genus, viewModel.Species, viewModel.Locales, viewModel.Description);

            if (fish != null)
            {
                // post a twitter update
                this.twitterService.PostFishAddition(fish, this.BuildAbsoulteUrl(fish));

                // log
                this.logger.LogAdd(fish, this.User.Identity.Name);
            }

            return fish != null ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id, bool? showSuccessMessage)
        {
            var viewModel = this.fishEditPageViewModelFactory.Build(id, Convert.ToBoolean(showSuccessMessage));

            return this.View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Update(FishEditFormViewModel vm)
        {
            this.TryUpdateModel(vm);

            var fish = this.fishRepository.Update(vm.Id, vm.Genus, vm.Species, vm.Locales, vm.Description);

            if (fish != null)
            {
                this.logger.LogUpdate(fish, this.User.Identity.Name);

                this.twitterService.PostFishUpdate(fish, this.BuildAbsoulteUrl(fish));
            }

            return fish != null ? new JsonResult { Data = true } : new JsonResult { Data = false };
        }

        public ActionResult Delete(int id)
        {
            this.fishRepository.Delete(id);

            return this.RedirectToAction("Index");
        }

        public ActionResult DeletePhoto(int fishId, int photoId)
        {
            this.photosRepository.Delete(photoId);

            return this.RedirectToAction("Update", new { id = fishId });
        }

        private string BuildAbsoulteUrl(Fish fish)
        {
            return UrlHelper.ToPublicUrl(new Uri(Url.Action("Index", "Fish", new { Area = string.Empty, fishName = fish.UrlName }), UriKind.Relative), this.Request);
        }
    }
}