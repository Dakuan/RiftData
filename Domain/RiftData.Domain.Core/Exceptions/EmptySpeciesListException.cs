using System;

namespace RiftData.Domain.Exceptions
{
    public class EmptySpeciesListException : Exception
    {
        public override string Message
        {
            get { return "can't have a genus with no species in! bad data"; }
        }
    }
}