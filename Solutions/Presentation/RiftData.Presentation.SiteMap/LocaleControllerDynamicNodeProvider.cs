using System.Collections.Generic;
using System.Linq;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap
{
    public class LocaleControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            var _dataContext = new RiftDataDataContext();

            var nodes = new List<DynamicNode>();

            _dataContext.Locales.ToList().ForEach(t =>
            {
                var node = new DynamicNode
                {
                    Controller = "Locale",
                    Title = t.Name,
                    Action = "Index"
                };

                node.RouteValues.Add("localeName", t.Name);

                nodes.Add(node);
            });
            return nodes;
        }
    }
}