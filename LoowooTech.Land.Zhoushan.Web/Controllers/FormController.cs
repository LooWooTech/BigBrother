﻿using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    [UserRoleFilter(UserRole.Maintain)]
    public class FormController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.Forms = Core.FormManager.GetForms();
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult GetYears(int formId)
        {
            var list = Core.FormManager.GetFormYears(formId).OrderByDescending(year => year);
            return JsonSuccessResult(list);
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult Charts()
        {
            var data = new Dictionary<Form, int[]>();
            var forms = Core.FormManager.GetForms(CurrentIdentity.FormIds);
            foreach (var form in forms)
            {
                var years = Core.FormManager.GetFormYears(form.ID);
                data.Add(form, years);
            }
            ViewBag.Data = data;
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult Write()
        {
            ViewBag.Forms = Core.FormManager.GetForms(CurrentIdentity.FormIds);
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            var form = Core.FormManager.GetForm(id) ?? new Form();
            ViewBag.Form = form;
            return View();
        }

        [HttpPost]
        public ActionResult Edit(Form form)
        {
            Core.FormManager.SaveForm(form);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            Core.FormManager.DeleteForm(id);
            return JsonSuccessResult();
        }

        public void UpdateState(int id, bool disable)
        {
            var model = Core.FormManager.GetForm(id);
            model.Disabled = disable;
            Core.FormManager.SaveForm(model);
        }
    }
}