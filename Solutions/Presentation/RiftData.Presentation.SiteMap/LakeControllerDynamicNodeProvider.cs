namespace RiftData.Presentation.SiteMap
{
    using System.Collections.Generic;
    using System.Linq;

    using MvcSiteMapProvider.Extensibility;

    using RiftData.Infrastructure.Data;

    public class LakeControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.Lakes.ToList().ForEach(
                    t =>
                        {
                            var node = new DynamicNode { Controller = "Lake", Title = t.Name, Action = "Index" };

                            node.RouteValues.Add("lakeName", t.Name);

                            nodes.Add(node);
                        });
                return nodes;
            }
        }
    }
}