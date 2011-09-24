using NUnit.Framework;
using WatiN.Core;

namespace RiftData.UiTests.Admin
{
    [TestFixture]
    public class HomePage
    {
        [Test]
        [RequiresSTA]
        public void should_start_google()
        {
            using (var browser = new IE("http://www.google.co.uk"))
            {
                Assert.IsTrue(browser.Title == "Google");
            }
        }
    }
}