namespace Tdd.Labs.MiniPricer.Externals
{
    public interface IVolatilityProvider
    {
        double GetVolatility();
        bool IsGrowth();
    }
}