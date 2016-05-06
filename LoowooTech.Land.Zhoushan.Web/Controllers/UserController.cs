using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LowooTech.Land.Zhoushan.Web.Controllers
{
    public class UserController : ControllerBase
    {
        public ActionResult Index(string searchKey, int page = 1, int rows = 20)
        {
            var parameter = new UserParameter
            {
                SearchKey = searchKey,
                Page = new PageParameter(page, rows),
            };

            ViewBag.List = Core.UserManager.GetUsers(parameter);
            ViewBag.Page = parameter.Page;
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.Model = Core.UserManager.GetUser(id) ?? new User { Role = UserRole.Reader };
            return View();
        }

        [HttpPost]
        public ActionResult Edit(User model)
        {
            Core.UserManager.Save(model);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            Core.UserManager.Delete(id);
            return JsonSuccessResult();
        }
    }
}