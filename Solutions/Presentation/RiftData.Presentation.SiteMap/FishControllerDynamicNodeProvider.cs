namespace RiftData.Presentation.SiteMap
{
    using System.Collections.Generic;
    using System.Linq;

    using MvcSiteMapProvider.Extensibility;

    using RiftData.Infrastructure.Data;

    public class FishControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.Fish.ToList().ForEach(
                    t =>
                        {
                            var node = new DynamicNode { Controller = "Fish", Title = t.Name, Action = "Index" };

                            node.RouteValues.Add("fishName", t.UrlName);

                            nodes.Add(node);
                        });
                return nodes;
            }
        }
    }
}