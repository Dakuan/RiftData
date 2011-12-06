using System;
using System.Web.Mvc;
using RiftData.ApplicationServices.Twitter;
using RiftData.Domain.Entities;
using RiftData.Domain.Exceptions;
using RiftData.Domain.Repositories;
using RiftData.Infrastructure.Data.Logging;
using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.ApplicationServices.CrudServices
{
    public class FishService : IFishService
    {
        private readonly IFishRepository fishRepository;

        public Fish Fish { get; set; }

        public FishService(IFishRepository fishRepository)
        {
            this.fishRepository = fishRepository;
        }

        public CrudResult AddFish(FishEditFormViewModel viewModel)
        {
            Fish fish = null;

            try
            {
                fish = this.fishRepository.Add(viewModel.Genus, viewModel.Species, viewModel.Locales,
                                                   viewModel.Description);
            }
            catch (ItemExistsException)
            {
                return new CrudResult {Success = false, Message = "Fish already exists in database"};
            }
            catch(Exception)
            {
                return new CrudResult { Success = false, Message = "An error occured" };
            }

            this.Fish = fish;

            return new CrudResult
                       {
                           Success = true,
                           Message = string.Format("{0} added to database", fish.Name)
                       };
        }
    }
}