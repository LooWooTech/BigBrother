using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class FormController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.Forms = Core.FormManager.GetForms();
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            var form = Core.FormManager.GetForm(id) ?? new Form();
            ViewBag.Form = form;
            ViewBag.Areas = Core.AreaManager.GetAreas();
            ViewBag.Types = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        [HttpPost]
        public ActionResult Edit(Form form)
        {
            Core.FormManager.SaveForm(form);
            return JsonSuccessResult();
        }
    }
}