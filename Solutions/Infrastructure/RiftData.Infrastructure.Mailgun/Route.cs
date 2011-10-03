namespace RiftData.Infrastructure.Mailgun
{
    using System.Xml;

    /// <summary>
    ///     Route represents the basic rule: the message for particular recipient R is forwarded to destination/callback D.
    ///     Route has 2 properties: pattern and destination. The pair (pattern, destination) must be unique.
    /// </summary>
    public class Route : MailgunResourceUpsertable<Route>
    {
        private static readonly ResourceInfo _resInfo = new ResourceInfo("routes", "route");

        public Route()
        {
        }

        /// <summary>
        ///     Construct the route.
        /// </summary>
        /// <param name = "pattern">
        ///     The pattern for matching the recipient.
        ///     There are 4 types of patterns:
        ///     1. '*' - match all.
        ///     2. exact string match (foo@bar.com)
        ///     3. a domain pattern, i.e. a string like "*@example.com" - matches all emails going to example.com
        ///     4. a regular expression
        /// </param>
        /// <param name = "destination">
        ///     1 An email address.
        ///     2 HTTP/HTTPS URL. A message will be HTTP POSTed there.
        /// </param>
        public Route(string pattern, string destination)
        {
            this.Pattern = pattern;
            this.Destination = destination;
        }

        public string Destination { get; set; }

        public string Pattern { get; set; }

        public override string ToString()
        {
            return string.Format("Route({0}, {1}, {2})", this.Pattern, this.Destination, this.Id);
        }

        internal override ResourceInfo getResourceInfo()
        {
            return _resInfo;
        }

        protected override bool onReadProperty(string propName, object propVal)
        {
            if (base.onReadProperty(propName, propVal))
            {
                return true;
            }
            switch (propName)
            {
                case "pattern":
                    this.Pattern = (string)propVal;
                    return true;
                case "destination":
                    this.Destination = (string)propVal;
                    return true;
                default:
                    return false;
            }
        }

        protected override void writeInnerXml(XmlWriter xw)
        {
            base.writeInnerXml(xw);
            this.writeARProperty(xw, "pattern", this.Pattern);
            this.writeARProperty(xw, "destination", this.Destination);
        }

        // our target is C# 2.0, don't use "structure initialization syntax"
    }
}