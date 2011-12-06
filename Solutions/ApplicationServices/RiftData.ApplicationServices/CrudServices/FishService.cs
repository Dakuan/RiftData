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

        public CrudResult CreateFish(FishEditFormViewModel viewModel)
        {
            try
            {
                this.Fish = this.fishRepository.Add(viewModel.Genus, viewModel.Species, viewModel.Locales,
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

            return new CrudResult
                       {
                           Success = true,
                           Message = string.Format("{0} added to database", Fish.Name)
                       };
        }

        public CrudResult UpdateFish(FishEditFormViewModel viewModel)
        {
            try
            {
                this.Fish = this.fishRepository.Update(viewModel.Id, viewModel.Genus, viewModel.Species,
                                                       viewModel.Locales, viewModel.Description);
            }
            catch(ItemDoesNotExistException)
            {
                return new CrudResult {Message = "Item does not exist", Success = false};
            }
            catch (Exception)
            {
                return new CrudResult {Success = false, Message = "An error occured"};
            }

            return new CrudResult {Success = true, Message = string.Format("{0} has been updated", Fish.Name)};
        }
    }
}