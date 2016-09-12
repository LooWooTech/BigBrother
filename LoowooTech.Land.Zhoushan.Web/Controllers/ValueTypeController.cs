using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    [UserRoleFilter(UserRole.Maintain)]
    public class ValueTypeController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.List = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.Model = Core.FormManager.GetNodeValueType(id) ?? new NodeValueType();
            return View();
        }

        [HttpPost]
        public ActionResult Edit(NodeValueType model)
        {
            Core.FormManager.SaveNodeValueType(model);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            Core.FormManager.DeleteNodeValueType(id);
            return JsonSuccessResult();
        }
    }
}