using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tdd.Labs.MiniPricer.Externals;

namespace Tdd.Labs.MiniPricer
{
    public class MiniPricer
    {
        IPublicHolidayProvider _publicHolidayProvider;
        public MiniPricer(IPublicHolidayProvider holidayProvider)
        {
            this._publicHolidayProvider = holidayProvider;
        }

        public MiniPricer()
        {
            this._publicHolidayProvider = new PublicHolidayProvider();
        }
        public double CalculatePrice(DateTime pricingDate, double currentPrice, double volatility)
        {
            var currentDate = DateTime.Today;
            var finalPrice = currentPrice;
            while (pricingDate > currentDate)
            {
                currentDate = currentDate.AddDays(1);
                if (this._publicHolidayProvider.IsPublicHoliday(currentDate) || currentDate.DayOfWeek == DayOfWeek.Saturday || currentDate.DayOfWeek == DayOfWeek.Sunday)
                    continue;
                finalPrice *= (1 + volatility / 100);
            }
            return finalPrice;
        }
    }
}
