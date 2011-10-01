using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap.Mobile
{
    public class GenusTypeControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.GenusTypes.ToList().ForEach(t =>
                {
                    var node = new DynamicNode { Controller = "GenusTypes", Title = t.Name, Action = "Index", Area = "Mobile"};

                    node.RouteValues.Add("genusTypeName", t.Name);

                    nodes.Add(node);
                });
                return nodes;
            }
        }
    }
}
