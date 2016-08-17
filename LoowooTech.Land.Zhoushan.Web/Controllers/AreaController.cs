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

        [UserRoleFilter(UserRole.Advanced)]
        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.List = Core.AreaManager.GetAreaTree();
            ViewBag.Model = Core.AreaManager.GetArea(id) ?? new Area();
            return View();
        }

        public ActionResult Dropdown(int areaId = 0, bool editValue = false, string controlName = "areaId")
        {
            if(editValue || CurrentIdentity.Role == UserRole.Branch)
            {
                ViewBag.List = Core.AreaManager.GetAreaTree(CurrentIdentity.AreaIds);
            }
            else
            {
                ViewBag.List = Core.AreaManager.GetAreaTree();
            }
            ViewBag.EditValue = editValue;

            ViewBag.ControlName = controlName;
            ViewBag.AreaID = areaId;
            return View();
        }

        [UserRoleFilter(UserRole.Advanced)]
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