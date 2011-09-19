using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.DtoServices.Extensions
{
    public static class ToSelectListExtensions
    {
        public static SelectList ToSelectList(this IEnumerable<IEntity> domainList)
        {
            return new SelectList(domainList, "Id", "Name");
        }

        public static SelectList ToSelectList(this IEnumerable<IEntity> domainList, int selectedEntityId)
        {
            return new SelectList(domainList, "Id", "Name", selectedEntityId);
        }

        public static SelectList ToSelectList(this IEnumerable<IEntity> domainList, string comment)
        {
            domainList.ToList().Insert(0, new SelectListComment { Id = 0, Name = comment });

            return ToSelectList(domainList);
        }

        public static SelectList ToSelectList(this IEnumerable<IEntity> domainList, int selectedEntityId, string comment)
        {
            domainList.ToList().Insert(0, new SelectListComment { Id = 0, Name = comment });

            return ToSelectList(domainList, selectedEntityId);
        }
    }

    public class SelectListComment: IEntity
    {
        public int Id { get; set; }

        public string Name { get; set; }
    }
}
