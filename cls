warning: LF will be replaced by CRLF in Tdd.Labs.MiniPricer/Externals/IPublicHolidayProvider.cs.
The file will have its original line endings in your working directory.
[1mdiff --git a/.vs/Tdd.Labs/v14/.suo b/.vs/Tdd.Labs/v14/.suo[m
[1mindex ca489de..db5475b 100644[m
Binary files a/.vs/Tdd.Labs/v14/.suo and b/.vs/Tdd.Labs/v14/.suo differ
[1mdiff --git a/Tdd.Labs.MiniPricer/Externals/IPublicHolidayProvider.cs b/Tdd.Labs.MiniPricer/Externals/IPublicHolidayProvider.cs[m
[1mindex b199528..11a3194 100644[m
[1m--- a/Tdd.Labs.MiniPricer/Externals/IPublicHolidayProvider.cs[m
[1m+++ b/Tdd.Labs.MiniPricer/Externals/IPublicHolidayProvider.cs[m
[36m@@ -1,8 +1,6 @@[m
 ﻿using System;[m
 using System.Collections.Generic;[m
[31m-using System.Linq;[m
[31m-using System.Text;[m
[31m-using System.Threading.Tasks;[m
[32m+[m
 [m
 namespace Tdd.Labs.MiniPricer.Externals[m
 {[m
[1mdiff --git a/Tdd.Labs.MiniPricer/Externals/PublicHolidayProvider.cs b/Tdd.Labs.MiniPricer/Externals/PublicHolidayProvider.cs[m
[1mdeleted file mode 100644[m
[1mindex ae9f4de..0000000[m
[1m--- a/Tdd.Labs.MiniPricer/Externals/PublicHolidayProvider.cs[m
[1m+++ /dev/null[m
[36m@@ -1,27 +0,0 @@[m
[31m-﻿using System;[m
[31m-using System.Collections.Generic;[m
[31m-using System.Linq;[m
[31m-using System.Text;[m
[31m-using System.Threading.Tasks;[m
[31m-[m
[31m-namespace Tdd.Labs.MiniPricer.Externals[m
[31m-{[m
[31m-    public class PublicHolidayProvider : IPublicHolidayProvider[m
[31m-    {[m
[31m-        List<DateTime> _holidays;[m
[31m-[m
[31m-        public PublicHolidayProvider()[m
[31m-        {[m
[31m-            this._holidays = new List<DateTime>();[m
[31m-        }[m
[31m-        public IEnumerable<DateTime> GetPublicHolidays()[m
[31m-        {[m
[31m-            return this._holidays?? Enumerable.Empty<DateTime>();[m
[31m-        }[m
[31m-[m
[31m-        public bool IsPublicHoliday(DateTime date)[m
[31m-        {[m
[31m-            throw new NotImplementedException();[m
[31m-        }[m
[31m-    }[m
[31m-}[m
[1mdiff --git a/Tdd.Labs.MiniPricer/MiniPricer.cs b/Tdd.Labs.MiniPricer/MiniPricer.cs[m
[1mindex 7407af6..38a3c3f 100644[m
[1m--- a/Tdd.Labs.MiniPricer/MiniPricer.cs[m
[1m+++ b/Tdd.Labs.MiniPricer/MiniPricer.cs[m
[36m@@ -19,16 +19,17 @@[m [mnamespace Tdd.Labs.MiniPricer[m
         {[m
             this._publicHolidayProvider = new PublicHolidayProvider();[m
         }[m
[31m-        public double CalculatePrice(DateTime pricingDate, double currentPrice, double volatility)[m
[32m+[m[32m        public double CalculatePrice(DateTime pricingDate, double currentPrice, IVolatilityProvider volatility)[m[41m[m
         {[m
             var currentDate = DateTime.Today;[m
             var finalPrice = currentPrice;[m
[32m+[m[32m            var volatilityValue = volatility.IsGrowth() ? volatility.GetVolatility() : volatility.GetVolatility() * -1;[m[41m [m
             while (pricingDate > currentDate)[m
             {[m
                 currentDate = currentDate.AddDays(1);[m
                 if (this._publicHolidayProvider.IsPublicHoliday(currentDate) || currentDate.DayOfWeek == DayOfWeek.Saturday || currentDate.DayOfWeek == DayOfWeek.Sunday)[m
                     continue;[m
[31m-                finalPrice *= (1 + volatility / 100);[m
[32m+[m[32m                finalPrice *= (1 +  volatilityValue/ 100);[m[41m[m
             }[m
             return finalPrice;[m
         }[m
[1mdiff --git a/Tdd.Labs.MiniPricer/Tdd.Labs.MiniPricer.csproj b/Tdd.Labs.MiniPricer/Tdd.Labs.MiniPricer.csproj[m
[1mindex 789b2bf..b54930e 100644[m
[1m--- a/Tdd.Labs.MiniPricer/Tdd.Labs.MiniPricer.csproj[m
[1m+++ b/Tdd.Labs.MiniPricer/Tdd.Labs.MiniPricer.csproj[m
[36m@@ -41,10 +41,13 @@[m
   </ItemGroup>[m
   <ItemGroup>[m
     <Compile Include="Externals\IPublicHolidayProvider.cs" />[m
[31m-    <Compile Include="Externals\PublicHolidayProvider.cs" />[m
[32m+[m[32m    <Compile Include="Objects\PublicHolidayProvider.cs" />[m
     <Compile Include="MiniPricer.cs" />[m
[32m+[m[32m    <Compile Include="Externals\IVolatilityProvider.cs" />[m
     <Compile Include="Properties\Assemblywarning: LF will be replaced by CRLF in Tdd.Labs.MiniPricer/Tdd.Labs.MiniPricer.csproj.
The file will have its original line endings in your working directory.
Info.cs" />[m
[32m+[m[32m    <Compile Include="Objects\Volatility.cs" />[m
   </ItemGroup>[m
[32m+[m[32m  <ItemGroup />[m
   <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" />[m
   <!-- To modify your build process, add your task inside one of the targets below and uncomment it. [m
        Other similar extension points exist, see Microsoft.Common.targets.[m
[1mdiff --git a/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.dll b/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.dll[m
[1mindex 90e482c..01aa106 100644[m
Binary files a/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.dll and b/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.dll differ
[1mdiff --git a/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.pdb b/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.pdb[m
[1mindex 65f0964..76198f0 100644[m
Binary files a/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.pdb and b/Tdd.Labs.MiniPricer/bin/Debug/Tdd.Labs.MiniPricer.pdb differ
[1mdiff --git a/Tdd.Labs.MiniPricer/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache b/Tdd.Labs.MiniPricer/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache[m
[1mindex 6ac0d2b..9160673 100644[m
Binary files a/Tdd.Labs.MiniPricer/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache and b/Tdd.Labs.MiniPricer/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache differ
[1mdiff --git a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.csproj.FileListAbsolute.txt b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.csproj.FileListAbsolute.txt[m
[1mindex 8d2788d..3245bef 100644[m
[1m--- a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.csproj.FileListAbsolute.txt[m
[1m+++ b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.csproj.FileListAbsolute.txt[m
[36m@@ -3,3 +3,8 @@[m [mc:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.Labs.M[m
 c:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.dll[m
 c:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.pdb[m
 C:\Users\MOHAMED AMINE\Documents\Visual Studio 2015\Projects\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.csprojResolveAssemblyReference.cache[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.Labs.MiniPricer\bin\Debug\Tdd.Labs.MiniPricer.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.Labs.MiniPricer\bin\Debug\Tdd.Labs.MiniPricer.pdb[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.csprojResolveAssemblyReference.cache[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.Labs.MiniPricer\obj\Debug\Tdd.Labs.MiniPricer.pdb[m
[1mdiff --git a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.dll b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.dll[m
[1mindex 90e482c..01aa106 100644[m
Binary files a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.dll and b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.dll differ
[1mdiff --git a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.pdb b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.pdb[m
[1mindex 65f0964..76198f0 100644[m
Binary files a/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.pdb and b/Tdd.Labs.MiniPricer/obj/Debug/Tdd.Labs.MiniPricer.pdb differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/MiniPricerStepOneTest.cs b/Tdd.labs.MiniPricerTests/MiniPricerStepOneTest.cs[m
[1mindex d6d4217..10ea7e2 100644[m
[1m--- a/Tdd.labs.MiniPricerTests/MiniPricerStepOneTest.cs[m
[1m+++ b/Tdd.labs.MiniPricerTests/MiniPricerStepOneTest.cs[m
[36m@@ -12,10 +12,13 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
     public class MiniPricerStepOneTest[m
     {[m
         [TestMethod][m
[31m-        public void ShouldReturnTodayPrice_Test()[m
[32m+[m[32m        public void ShouldReturnTodayPrice_Test(double expectedPrice,DateTime futureDate)[m
         {[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(0);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
             var today = DateTime.Today;[m
[31m-            var volatility = 0d;[m
             var todayPrice = 100d;[m
 [m
             var pricer = new MiniPricer();[m
[36m@@ -30,8 +33,11 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
             var futurDate = DateTime.Today.AddDays(1);[m
[31m-            var volatility = 50d;[m
             var todayPrice = 200d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
[36m@@ -46,8 +52,11 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
             var futurDate = DateTime.Today.AddDays(2);[m
[31m-            var volatility = 50d;[m
             var todayPrice = 200d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
[36m@@ -62,14 +71,17 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);[m
[31m-            var futurDate = new DateTime(2017, 10, 14);[m
[31m-            var volatility = 50d;[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
[32m+[m[32m            var futurDate = DateTime.Today.AddDays(3);// new DateTime(2017, 10, 14);[m
             var todayPrice = 800d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
             var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);[m
 [m
[31m-            Assert.AreEqual(2700, price);[m
[32m+[m[32m            Assert.AreEqual(1800, price);[m
         }[m
 [m
         [TestMethod][m
[36m@@ -78,14 +90,17 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);[m
[31m-            var futurDate = new DateTime(2017, 10, 15);[m
[31m-            var volatility = 50d;[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
[32m+[m[32m            var futurDate = DateTime.Today.AddDays(4); //new DateTime(2017, 10, 15);[m
             var todayPrice = 800d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
             var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);[m
 [m
[31m-            Assert.AreEqual(2700, price);[m
[32m+[m[32m            Assert.AreEqual(1800, price);[m
         }[m
 [m
         [TestMethod][m
[36m@@ -94,14 +109,17 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(Enumerable.Empty<DateTime>());[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(It.IsAny<DateTime>())).Returns(false);[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
             var futurDate = new DateTime(2017, 10, 16);[m
[31m-            var volatility = 50d;[m
             var todayPrice = 800d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
             var price = pricer.CalculatePrice(futurDate, todayPrice, volatility);[m
 [m
[31m-            Assert.AreEqual(4050, price);[m
[32m+[m[32m            Assert.AreEqual(2700, price);[m
         }[m
 [m
         [TestMethod][m
[36m@@ -110,8 +128,11 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime>() { DateTime.Today.AddDays(2) });[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(DateTime.Today.AddDays(2))).Returns(true);[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
             DateTime futurDate = moqPublicHolidayProvider.Object.GetPublicHolidays().FirstOrDefault();[m
[31m-            var volatility = 50d;[m
             var todayPrice = 200d;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
[36m@@ -125,8 +146,11 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
         public void ShouldReturnPriceForPublicHolidayEqualSuturday_Test()[m
         {[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
[31m-            var testDate = new DateTime(2017, 10, 14);[m
[31m-            var volatility = 50d;[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+warning: LF will be replaced by CRLF in Tdd.labs.MiniPricerTests/MiniPricerStepOneTest.cs.
The file will have its original line endings in your working directory.
[m[32m            var volatility = moqVolatilityProvider.Object;[m
[32m+[m[32m            var testDate = DateTime.Today.AddDays(3);// new DateTime(2017, 10, 14);[m
             var todayPrice = 800d;[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime> { testDate });[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(testDate)).Returns(true);[m
[36m@@ -134,23 +158,26 @@[m [mnamespace Tdd.labs.MiniPricerTests[m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
             var price = pricer.CalculatePrice(testDate, todayPrice, volatility);[m
 [m
[31m-            Assert.AreEqual(2700, price);[m
[32m+[m[32m            Assert.AreEqual(1800, price);[m
         }[m
 [m
         [TestMethod][m
         public void ShouldReturnPriceForPublicHolidayEqualSunday_Test()[m
         {[m
             Mock<IPublicHolidayProvider> moqPublicHolidayProvider = new Mock<IPublicHolidayProvider>();[m
[31m-            var testDate = new DateTime(2017, 10, 15);[m
[31m-            var volatility = 50d;[m
[32m+[m[32m            var testDate = DateTime.Today.AddDays(4);//  new DateTime(2017, 10, 15);[m
             var todayPrice = 800d;[m
             moqPublicHolidayProvider.Setup(p => p.GetPublicHolidays()).Returns(new List<DateTime> { testDate });[m
             moqPublicHolidayProvider.Setup(p => p.IsPublicHoliday(testDate)).Returns(true);[m
[32m+[m[32m            Mock<IVolatilityProvider> moqVolatilityProvider = new Mock<IVolatilityProvider>();[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.GetVolatility()).Returns(50);[m
[32m+[m[32m            moqVolatilityProvider.Setup(p => p.IsGrowth()).Returns(true);[m
[32m+[m[32m            var volatility = moqVolatilityProvider.Object;[m
 [m
             var pricer = new MiniPricer(moqPublicHolidayProvider.Object);[m
             var price = pricer.CalculatePrice(testDate, todayPrice, volatility);[m
 [m
[31m-            Assert.AreEqual(2700, price);[m
[32m+[m[32m            Assert.AreEqual(1800, price);[m
         }[m
     }[m
 }[m
[1mdiff --git a/Tdd.labs.MiniPricerTests/Tdd.labs.MiniPricerTests.csproj b/Tdd.labs.MiniPricerTests/Tdd.labs.MiniPricerTests.csproj[m
[1mindex e74a5f6..193f942 100644[m
[1m--- a/Tdd.labs.MiniPricerTests/Tdd.labs.MiniPricerTests.csproj[m
[1m+++ b/Tdd.labs.MiniPricerTests/Tdd.labs.MiniPricerTests.csproj[m
[36m@@ -60,6 +60,7 @@[m
   </Choose>[m
   <ItemGroup>[m
     <Compile Include="MiniPricerStepOneTest.cs" />[m
[32m+[m[32m    <Compile Include="MiniPricerStepTwoTest.cs" />[m
     <Compile Include="Properties\AssemblyInfo.cs" />[m
   </ItemGroup>[m
   <ItemGroup>[m
[1mdiff --git a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.dll b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.dll[m
[1mindex 90e482c..01aa106 100644[m
Binary files a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.dll and b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.dll differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.pdb b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.pdb[m
[1mindex 65f0964..76198f0 100644[m
Binary files a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.pdb and b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.Labs.MiniPricer.pdb differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.dll b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.dll[m
[1mindex 12b13b6..1156e20 100644[m
Binary files a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.dll and b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.dll differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.pdb b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.pdb[m
[1mindex 3bf434c..44b041d 100644[m
Binary files a/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.pdb and b/Tdd.labs.MiniPricerTests/bin/Debug/Tdd.labs.MiniPricerTests.pdb differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache b/Tdd.labs.MiniPricerTests/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache[m
[1mindex 423a1db..95bbfa8 100644[m
Binary files a/Tdd.labs.MiniPricerTests/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache and b/Tdd.labs.MiniPricerTests/obj/Debug/DesignTimeResolveAssemblyReferencesInput.cache differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csproj.FileListAbsolute.txt b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csproj.FileListAbsolute.txt[m
[1mindex 0c2082c..bc310c0 100644[m
[1m--- a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csproj.FileListAbsolute.txt[m
[1m+++ b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csproj.FileListAbsolute.txt[m
[36m@@ -11,3 +11,16 @@[m [mc:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.labs.M[m
 c:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.dll[m
 c:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.pdb[m
 c:\users\mohamed amine\documents\visual studio 2015\Projects\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.xml[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\obj\Debug\Tdd.labs.MiniPricerTests.csprojResolveAssemblyReference.cache[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\obj\Debug\Tdd.labs.MiniPricerTests.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\obj\Debug\Tdd.labs.MiniPricerTests.pdb[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Tdd.labs.MiniPricerTests.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Tdd.labs.MiniPricerTests.pdb[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Castle.Core.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Microsoft.VisualStudio.QualityTools.UnitTestFramework.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Tdd.Labs.MiniPricer.dll[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Tdd.Labs.MiniPricer.pdb[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.pdb[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Moq.xml[m
[32m+[m[32mD:\Source\Github\Tdd.Labs\Tdd.labs.MiniPricerTests\bin\Debug\Microsoft.VisualStudio.QualityTools.UnitTestFramework.xml[m
[1mdiff --git a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csprojResolveAssemblyReference.cache b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csprojResolveAssemblyReference.cache[m
[1mindex be0951a..16874c4 100644[m
Binary files a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csprojResolveAssemblyReference.cache and b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.csprojResolveAssemblyReference.cache differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.dll b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.dll[m
[1mindex 12b13b6..1156e20 100644[m
Binary files a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.dll and b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.dll differ
[1mdiff --git a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.pdb b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.pdb[m
[1mindex 3bf434c..44b041d 100644[m
Binary files a/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.pdb and b/Tdd.labs.MiniPricerTests/obj/Debug/Tdd.labs.MiniPricerTests.pdb differ
warning: LF will be replaced by CRLF in Tdd.labs.MiniPricerTests/Tdd.labs.MiniPricerTests.csproj.
The file will have its original line endings in your working directory.
