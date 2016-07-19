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

        public ActionResult Charts()
        {
            var data = new Dictionary<Form, int[]>();
            var forms  = Core.FormManager.GetForms();
            foreach (var form in forms)
            {
                var years = Core.FormManager.GetFormYears(form.ID);
                data.Add(form, years);
            }
            ViewBag.Data = data;
            return View();
        }

        public ActionResult Write()
        {
            ViewBag.Forms = Core.FormManager.GetForms();
            return View();
        }

        [UserRoleFilter(UserRole.Writer)]
        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            var form = Core.FormManager.GetForm(id) ?? new Form();
            ViewBag.Form = form;
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        [UserRoleFilter(UserRole.Writer)]
        [HttpPost]
        public ActionResult Edit(Form form)
        {
            Core.FormManager.SaveForm(form);
            return JsonSuccessResult();
        }
    }
}