using Microsoft.AspNetCore.Mvc;

namespace WebApplication2.Controllers
{
    [Route("api/Hello")]
    [ApiController]
    public class HelloController : ControllerBase
    {
        //domainadresi/api/Hello
        [HttpGet]
        public IActionResult Get(string YourName)
        {
            List<string> _data = new List<string>()
            {
                "Hello Ziraat Team from " + YourName
            };

            return Ok(_data);
        }
    }
}