using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tdd.Labs.MiniPricer.Externals
{
    public interface IPublicHolidayProvider
    {
        IEnumerable<DateTime> GetPublicHolidays();
        bool IsPublicHoliday(DateTime date);
    }
}
