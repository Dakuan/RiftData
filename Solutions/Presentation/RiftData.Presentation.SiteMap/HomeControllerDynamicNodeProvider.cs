using System;
using System.Collections.Generic;
using System.Linq;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap
{
    public class HomeControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            using (var dataContext = new RiftDataDataContext())
            {
                var nodes = new List<DynamicNode>();

                dataContext.GenusTypes.ToList().ForEach(t =>
                                                                  {
                                                                      var node = new DynamicNode
                                                                                     {
                                                                                         Controller = "Home",
                                                                                         Title = t.Name,
                                                                                         Action = "Index"
                                                                                     };

                                                                      node.RouteValues.Add("genusTypeName", t.Name);

                                                                      nodes.Add(node);
                                                                  });

                return nodes;
            }
        }

        public override CacheDescription GetCacheDescription()
        {
            return new CacheDescription("HomeControllerDynamicNodeProvider")
                       {
                           SlidingExpiration = TimeSpan.FromMilliseconds(1)
                       };
        } 
    }
}