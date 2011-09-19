namespace RiftData.Presentation.SiteMap
{
    using System.Collections.Generic;
    using System.Linq;

    using MvcSiteMapProvider.Extensibility;

    using RiftData.Infrastructure.Data;

    public class SpeciesControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.Species.ToList().ForEach(
                    t =>
                        {
                            var node = new DynamicNode { Controller = "Species", Title = t.UrlName, Action = "Index" };

                            node.RouteValues.Add("speciesFullName", t.UrlName);

                            nodes.Add(node);
                        });

                return nodes;
            }
        }
    }
}