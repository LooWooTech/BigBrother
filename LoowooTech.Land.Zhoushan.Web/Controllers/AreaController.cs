using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    [UserRoleFilter(UserRole.Maintain)]
    public class AreaController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            ViewBag.Model = Core.AreaManager.GetArea(id) ?? new Area();
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult Dropdown(int areaId = 0, bool editValue = false, string controlName = "areaId")
        {
            ViewBag.List = Core.AreaManager.GetAreaTree(editValue ? CurrentIdentity.ReadAreaIds : CurrentIdentity.AreaIds);
            ViewBag.EditValue = editValue;

            ViewBag.ControlName = controlName;
            ViewBag.AreaID = areaId;
            return View();
        }

        [HttpPost]
        public ActionResult Edit(Area model)
        {
            Core.AreaManager.Save(model);
            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Advanced)]
        public ActionResult Delete(int id)
        {
            Core.AreaManager.Delete(id);
            return JsonSuccessResult();
        }
    }
}