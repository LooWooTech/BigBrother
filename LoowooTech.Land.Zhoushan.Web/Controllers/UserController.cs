using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class UserController : ControllerBase
    {
        [UserAuthorize(Enabled = false)]
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [UserAuthorize(Enabled = false)]
        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                throw new ArgumentException("参数错误");
            }
            var user = Core.UserManager.GetUser(username, password);
            if (user != null)
            {
                AuthorizeHelper.Login(HttpContext, user);
            }
            else
            {
                throw new HttpException(401, "登录失败");
            }
            return JsonSuccessResult();
        }

        [HttpGet]
        public ActionResult EditPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult EditPassword(string oldPassword, string newPassword, string rePassword)
        {
            if(string.IsNullOrEmpty(oldPassword) || string.IsNullOrEmpty(newPassword))
            {
                throw new AggregateException("请输入密码");
            }
            if (newPassword != rePassword)
            {
                throw new ArgumentException("确认密码必须和新密码一致");
            }
            var user = Core.UserManager.GetUser(CurrentIdentity.Name, oldPassword);
            if (user == null)
            {
                throw new HttpException(401, "原密码输入不正确");
            }
            user.Password = newPassword;
            Core.UserManager.Save(user);
            return JsonSuccessResult();
        }

        public ActionResult Logout()
        {
            AuthorizeHelper.Logout(HttpContext);
            return RedirectToAction("Login");
        }


        [UserRoleFilter(UserRole.Administrator)]
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

        [UserRoleFilter(UserRole.Administrator)]
        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.Model = Core.UserManager.GetUser(id) ?? new User { Role = UserRole.Branch };
            ViewBag.Areas = Core.AreaManager.GetAreas();
            return View();
        }

        [UserRoleFilter(UserRole.Administrator)]
        [HttpPost]
        public ActionResult Edit(User model)
        {
            Core.UserManager.Save(model);
            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Administrator)]
        public ActionResult Delete(int id)
        {
            Core.UserManager.Delete(id);
            return JsonSuccessResult();
        }
    }
}