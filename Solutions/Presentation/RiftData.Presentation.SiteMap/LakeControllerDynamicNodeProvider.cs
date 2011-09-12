using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap
{
    public class LakeControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            var _dataContext = new RiftDataDataContext();

            var nodes = new List<DynamicNode>();

            _dataContext.Lakes.ToList().ForEach(t =>
            {
                var node = new DynamicNode
                {
                    Controller = "Lake",
                    Title = t.Name,
                    Action = "Index"
                };

                node.RouteValues.Add("lakeName", t.Name);

                nodes.Add(node);
            });
            return nodes;
        }
    }
}
