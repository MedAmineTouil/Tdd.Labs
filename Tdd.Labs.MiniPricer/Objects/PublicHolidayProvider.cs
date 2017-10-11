using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tdd.Labs.MiniPricer.Externals
{
    public class PublicHolidayProvider : IPublicHolidayProvider
    {
        List<DateTime> _holidays;

        public PublicHolidayProvider()
        {
            this._holidays = new List<DateTime>();
        }
        public IEnumerable<DateTime> GetPublicHolidays()
        {
            return this._holidays?? Enumerable.Empty<DateTime>();
        }

        public bool IsPublicHoliday(DateTime date)
        {
            return this._holidays.Contains(date);
        }
    }
}
