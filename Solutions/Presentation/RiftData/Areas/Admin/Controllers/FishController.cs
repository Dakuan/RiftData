using RiftData.ApplicationServices.CrudServices;
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

        private readonly IFishService fishService;

        private readonly ITwitterService twitterService;

        private readonly IFishPageViewModelFactory fishPageViewModelFactory;

        private readonly IFishRepository fishRepository;

        private readonly ILogger logger;

        private readonly IPhotosRepository photosRepository;

        private readonly ISpeciesRepository speciesRepository;

        public FishController(IFishService fishService, ITwitterService twitterService, IFishPageViewModelFactory fishPageViewModelFactory, IFishEditPageViewModelFactory fishEditPageViewModelFactory, IFishRepository fishRepository, ISpeciesRepository speciesRepository, IPhotosRepository photosRepository, ILogger logger)
        {
            this.fishService = fishService;
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
        public JsonResult Create(FishEditFormViewModel viewModel)
        {
            this.TryUpdateModel(viewModel);

            var result = this.fishService.CreateFish(viewModel);

            if (result.Success)
            {
                // post a twitter update
                this.twitterService.PostFishAddition(this.fishService.Fish, this.BuildAbsoulteUrl(this.fishService.Fish));

                // log
                this.logger.LogAdd(this.fishService.Fish, this.User.Identity.Name);
            }

            return new JsonResult {Data = result};
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Update(int id, bool? showSuccessMessage)
        {
            var viewModel = this.fishEditPageViewModelFactory.Build(id, Convert.ToBoolean(showSuccessMessage));

            return this.View(viewModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult Update(FishEditFormViewModel vm)
        {
            this.TryUpdateModel(vm);

            var result = this.fishService.UpdateFish(vm);

            if(result.Success)
            {
                this.logger.LogUpdate(this.fishService.Fish, this.User.Identity.Name);

                this.twitterService.PostFishUpdate(this.fishService.Fish, this.BuildAbsoulteUrl(this.fishService.Fish));
            }

            return new JsonResult {Data = result};
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