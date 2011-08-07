﻿using System;
using RiftData.Domain.Entities;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class DtoFactory : IDtoFactory
    {
        public FishDto Build(Fish fish)
        {
            return new FishDto
                       {
                           Id = fish.Id,
                           Name = fish.Name,
                           LocaleName = fish.Locale.Name,
                           Latitude = fish.Locale.Latitude,
                           Longitude = fish.Locale.Longitude
                       };
        }

        public LocaleDto Build(Locale locale)
        {
            return new LocaleDto
                       {
                           Id = locale.Id,
                           Name = locale.Name,
                           Latitude = locale.Latitude,
                           Longitude = locale.Longitude
                       };
        }

        public SpeciesDto Build(Species species)
        {
            return new SpeciesDto
                       {
                           Id = species.Id,
                           Name = species.FullName,
                           UrlName = species.UrlName
                       };
        }
    }
}
