using System;
using System.Collections.Generic;


namespace Tdd.Labs.MiniPricer.Externals
{
    public interface IPublicHolidayProvider
    {
        IEnumerable<DateTime> GetPublicHolidays();
        bool IsPublicHoliday(DateTime date);
    }
}
