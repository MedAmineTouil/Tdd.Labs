using System;
using Tdd.Labs.MiniPricer.Externals;
namespace Tdd.Labs.MiniPricer
{
    public class Volatility : IVolatilityProvider
    {
        double _value;
        bool _isGrowth;

        public double GetVolatility()
        {
            return this._value;
        }

        bool IVolatilityProvider.IsGrowth()
        {
            return this._isGrowth;
        }
    }
}