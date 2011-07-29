using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftMap.Domain.Factories.Exceptions
{
    public class NullDataObjectException : Exception
    {
        public override string Message
        {
            get { return "The dataobject was null, probably doesn't exist in the database"; }
        }
    }
}
