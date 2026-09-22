using Xunit;
using SampleApp;

namespace SampleApp.Tests;

public class UnitTest1
{
    [Fact]
    public void TestAdd()
    {
        Assert.Equal(4, Program.Add(2, 2));
    }
}
