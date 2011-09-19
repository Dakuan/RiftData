﻿namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class GenusDtoService : IGenusDtoService
    {
        private readonly IGenusRepository _genusRepository;

        public GenusDtoService(IGenusRepository genusRepository)
        {
            this._genusRepository = genusRepository;
        }

        public IEnumerable<GenusDto> GetGenusDtos(int genusTypeId)
        {
            return this._genusRepository.GetOfIdWithFish(genusTypeId).ToDtoList();
        }

        public IList<GenusDto> GetGenusDtos()
        {
            return this._genusRepository.GetAll().ToDtoList();
        }
    }
}