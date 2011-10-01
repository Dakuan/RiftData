using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap.Mobile
{
    public class SpeciesControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.Species.ToList().ForEach(t =>
                {
                    var node = new DynamicNode();

                    node.Area = "Mobile";

                    node.Controller = "Species";

                    node.Action = "Index";

                    node.RouteValues.Add("speciesName", "Cyathochromis_obliquidens");

                    nodes.Add(node);
                });
                return nodes;
            }
        }
    }
}
