using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class ValueTypeController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.List = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.Model = Core.FormManager.GetNodeValueType(id) ?? new NodeValueType();
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        [HttpPost]
        public ActionResult Edit(NodeValueType model)
        {
            Core.FormManager.SaveNodeValueType(model);
            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult Delete(int id)
        {
            Core.FormManager.DeleteNodeValueType(id);
            return JsonSuccessResult();
        }
    }
}