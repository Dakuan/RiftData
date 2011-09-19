namespace RiftData.Presentation.Contracts.Admin
{
    using System.Collections.Generic;
    using System.Web.Mvc;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Enums;

    public interface ILocaleService
    {
        bool CreateLocale(string name, double latitude, double longitude);

        void DeleteLocale(int id);

        List<Locale> GetAllLocales();

        SelectList GetAllLocalesSelectList();

        Locale GetLocale(int id);

        UpdateResult UpdateLocale(int id, string name, double latitude, double longitude);
    }
}