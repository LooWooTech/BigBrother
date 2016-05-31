using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class AreaController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            return View();
        }

        [UserRoleFilter(UserRole.Writer)]
        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            ViewBag.Model = Core.AreaManager.GetArea(id) ?? new Area();
            return View();
        }

        public ActionResult Dropdown(int areaId = 0, string controlName = "areaId")
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            ViewBag.ControlName = controlName;
            ViewBag.AreaID = areaId;
            return View();
        }

        [UserRoleFilter(UserRole.Writer)]
        [HttpPost]
        public ActionResult Edit(Area model)
        {
            Core.AreaManager.Save(model);
            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Writer)]
        public ActionResult Delete(int id)
        {
            Core.AreaManager.Delete(id);
            return JsonSuccessResult();
        }
    }
}