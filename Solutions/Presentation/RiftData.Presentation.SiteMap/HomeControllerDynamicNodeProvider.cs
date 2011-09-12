using System;
using System.Collections.Generic;
using System.Linq;
using MvcSiteMapProvider.Extensibility;
using RiftData.Infrastructure.Data;

namespace RiftData.Presentation.SiteMap
{
    public class HomeControllerDynamicNodeProvider : DynamicNodeProviderBase
    {
        private  RiftDataDataContext _dataContext;

        //public HomeControllerDynamicNodeProvider(RiftDataDataContext dataContext)
        //{
        //    _dataContext = dataContext;
        //}

        public override IEnumerable<DynamicNode> GetDynamicNodeCollection()
        {
            _dataContext = new RiftDataDataContext();

            var nodes = new List<DynamicNode>();

            this._dataContext.GenusTypes.ToList().ForEach(t =>
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

        public override CacheDescription GetCacheDescription()
        {
            return new CacheDescription("HomeControllerDynamicNodeProvider")
                       {
                           SlidingExpiration = TimeSpan.FromMilliseconds(1)
                       };
        } 
    }
}