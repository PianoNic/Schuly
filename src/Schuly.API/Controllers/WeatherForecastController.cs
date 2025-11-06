using Microsoft.AspNetCore.Mvc;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        [HttpGet(Name = "GetWeatherForecast")]
        public ActionResult Get()
        {
            return Ok("Weather forecast data");
        }
    }
}
