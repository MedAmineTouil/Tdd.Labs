using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Tdd.Labs.MiniPricer;
using Tdd.Labs.MiniPricer.Externals;
using Moq;
using System.Collections.Generic;
using System.Linq;

namespace Tdd.labs.MiniPricerTests
{
    [TestClass]
    public class MiniPricerStepOneTest
    {
        [TestMethod]
        public void ShouldReturnTodayPrice_Test(double expectedPrice,DateTime futureDate)
        {
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(0);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var today = DateTime.Today;
            var todayPrice = 100d;

            var pricer = new MiniPricer();
            var price = pricer.CalculatePrice(today, todayPrice, volatility);

            Assert.AreEqual(todayPrice, price);
        }

        [TestMethod]
        public void ShouldReturnOneDayFuturPrice_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var futurDate = DateTime.Today.AddDays(1);
            var todayPrice = 200d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(300, price);
        }

        [TestMethod]
        public void ShouldReturnMoreThanOneDayFuturPrice_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var futurDate = DateTime.Today.AddDays(2);
            var todayPrice = 200d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(450, price);
        }

        [TestMethod]
        public void ShouldReturnPriceForSaturday_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var futurDate = DateTime.Today.AddDays(3);// new DateTime(2017, 10, 14);
            var todayPrice = 800d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(1800, price);
        }

        [TestMethod]
        public void ShouldReturnPriceForSunday_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var futurDate = DateTime.Today.AddDays(4); //new DateTime(2017, 10, 15);
            var todayPrice = 800d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(1800, price);
        }

        [TestMethod]
        public void ShouldReturnPriceWhenSaturdayAndSundayAreInTheMiddle_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var futurDate = new DateTime(2017, 10, 16);
            var todayPrice = 800d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(2700, price);
        }

        [TestMethod]
        public void ShouldReturnPriceForPublicHoliday_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime>() { DateTime.Today.AddDays(2) });
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(DateTime.Today.AddDays(2))).Returns(true);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            DateTime futurDate = moqPublicHolidayProvider.Object.GetPublicHolidays().FirstOrDefault();
            var todayPrice = 200d;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);

            Assert.AreEqual(300, price);

        }

        [TestMethod]
        public void ShouldReturnPriceForPublicHolidayEqualSuturday_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;
            var testDate = DateTime.Today.AddDays(3);// new DateTime(2017, 10, 14);
            var todayPrice = 800d;
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime> { testDate });
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(testDate)).Returns(true);

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(testDate, todayPrice, volatility);

            Assert.AreEqual(1800, price);
        }

        [TestMethod]
        public void ShouldReturnPriceForPublicHolidayEqualSunday_Test()
        {
            Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();
            var testDate = DateTime.Today.AddDays(4);//  new DateTime(2017, 10, 15);
            var todayPrice = 800d;
            moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime> { testDate });
            moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(testDate)).Returns(true);
            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();
            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);
            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);
            var volatility = moqVolatilityProvider.Object;

            var pricer = new MiniPricer(moqPublicHolidayProvider.Object);
            var price = pricer.CalculatePrice(testDate, todayPrice, volatility);

            Assert.AreEqual(1800, price);
        }
    }
}
