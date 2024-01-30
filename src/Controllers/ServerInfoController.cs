using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Diagnostics;
using System.IO;

namespace ri_web_app.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ServerInfoController : ControllerBase
    {
        
        static double GetAverageProcessorLoad()
        {
            using (PerformanceCounter cpuCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total"))
            {
               cpuCounter.NextValue();
               System.Threading.Thread.Sleep(1000);
               double averageLoad = cpuCounter.NextValue();
               return Math.Round(averageLoad, 2);
            }
        }


        static string FormatBytes(long bytes)
        {
            string[] suffixes = { "B", "KB", "MB", "GB", "TB" };
            int suffixIndex = 0;

            double formattedSize = bytes;

            while (formattedSize >= 1024 && suffixIndex < suffixes.Length - 1)
            {
                formattedSize /= 1024;
                suffixIndex++;
            }

            return $"{formattedSize:N2} {suffixes[suffixIndex]}";
        }

        [HttpGet("/api/serverinfo")]
        public IActionResult GetServerInfo()
        {
            long availableSpace=0;
            double averageLoad = GetAverageProcessorLoad();
            DriveInfo[] drives = DriveInfo.GetDrives();
            foreach (DriveInfo drive in drives)
            {
                availableSpace += drive.AvailableFreeSpace;
            }
            return Ok(new { AvgLoad=averageLoad.ToString(),  SpaceAvailable= FormatBytes(availableSpace) });
        }

        [HttpGet("/api/returnvalue")]
        public IActionResult GetReturnValue()
        {
            try
            {
                string jsonContent = System.IO.File.ReadAllText("tech_assess.json");
                var data = JsonConvert.DeserializeObject<dynamic>(jsonContent);
                var returnValue = data.tech.return_value.Value.ToString();                
                return Ok(JsonConvert.SerializeObject( new { tech=new { return_value = returnValue} }, Formatting.Indented));                
             }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = ex.Message });
            }
        }

        [HttpPost("/api/returnvalue")]
        public IActionResult UpdateReturnValue([FromBody] dynamic requestBody)
        {
            try
            {
                string jsonContent = System.IO.File.ReadAllText("tech_assess.json");
                dynamic data = JsonConvert.DeserializeObject<dynamic>(jsonContent);

                data.return_value = requestBody.return_value;

                System.IO.File.WriteAllText("tech_assess.json", JsonConvert.SerializeObject(data));

                return Ok(new { message = "return_value updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = ex.Message });
            }
        }
    }
}
