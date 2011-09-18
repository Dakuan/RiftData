using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Domain.Entities;
using RiftData.Domain.Enums;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface ILocaleService
    {
        SelectList GetAllLocalesSelectList();

        List<Locale> GetAllLocales();

        Locale GetLocale(int id);

        UpdateResult UpdateLocale(int id, string name, double latitude, double longitude);

        bool CreateLocale(string name, double latitude, double longitude);

        void DeleteLocale(int id);
    }
}
