using System;

namespace RiftData.Domain.Exceptions
{
    public class NullDataObjectException : Exception
    {
        public override string Message
        {
            get { return "The dataobject was null, probably doesn't exist in the database"; }
        }
    }
}
