namespace Schuly.Tests;

public class UnitTest1
{
    [Test]
    public async Task Test_Example()
    {
        // Arrange
        int a = 5;
        int b = 10;

        // Act
        int result = a + b;

        // Assert
        await Assert.That(result).IsEqualTo(15);
    }
}
