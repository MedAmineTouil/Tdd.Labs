using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;
using System.Linq;
using Tdd.Labs.MiniPricer;
using Tdd.Labs.MiniPricer.Externals;

namespace Tdd.labs.MiniPricerTests
{
    [TestClass]
    public class MiniPricerStepTwoTest
    {
        [TestMethod]
        public void ShouldCalculateDecreasingVolatilityForNextBusinessDay_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>);
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(false);
            MiniPricer pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            DateTime targetDate = DateTime.Today.AddDays(1);
            double currentPrice = 400;

            var newPrice = pricer.CalculatePrice(targetDate, currentPrice, moqVolatilityProvider.Object);

            Assert.AreEqual(200, newPrice); 
        }
    }
}
