using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class ExcelController : ControllerBase
    {
        [HttpGet]
        public ActionResult Import()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Import(int formId)
        {
            throw new NotImplementedException();

            //var template = Core.TemplateManager.GetTemplate(formId);

            //var data = Core.TemplateManager.GetData(Request.Files[0].InputStream, template);

        }
    }
}