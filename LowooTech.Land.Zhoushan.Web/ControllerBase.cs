using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Managers;
using LowooTech.Land.Zhoushan.Web.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace LowooTech.Land.Zhoushan.Web
{
    public class ControllerBase : AsyncController
    {
        protected UserIdentity CurrentIdentity { get; private set; }

        protected ManagerCore Core { get { return ManagerCore.Instance; } }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (Thread.CurrentPrincipal.Identity is UserIdentity)
            {
                CurrentIdentity = (UserIdentity)Thread.CurrentPrincipal.Identity;
            }
            else
            {
                CurrentIdentity = UserIdentity.Anonymouse;
            }
            ViewBag.CurrentIdentity = CurrentIdentity;
            ViewBag.Controller = filterContext.RequestContext.RouteData.Values["controller"];
            ViewBag.Action = filterContext.RequestContext.RouteData.Values["action"];
            base.OnActionExecuting(filterContext);
        }

        private ActionResult ContentResult<T>(T data)
        {
            return new ContentResult { Content = data.ToJson(), ContentEncoding = System.Text.Encoding.UTF8, ContentType = "text/json" };
        }

        protected ActionResult JsonSuccessResult<T>(T data)
        {
            return ContentResult(new { result = 1, data = data });
        }

        protected ActionResult JsonSuccessResult()
        {
            return ContentResult(new { result = 1 });
        }

        protected ActionResult JsonErrorResult(string message)
        {
            return ContentResult(new { result = 0, message = message });
        }

        protected ActionResult JsonErrorResult(Exception ex)
        {
            return ContentResult(new { result = 0, message = ex.Message, stackTrace = ex.StackTrace });
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            if (filterContext.ExceptionHandled)
                return;

            filterContext.ExceptionHandled = true;
            filterContext.HttpContext.Response.Clear();
            if (filterContext.HttpContext.Response.StatusCode == 200)
            {
                filterContext.HttpContext.Response.StatusCode = filterContext.Exception.GetHttpStatusCode();
            }
            filterContext.HttpContext.Response.TrySkipIisCustomErrors = true;
            var ex = filterContext.Exception.GetInnerException();
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                filterContext.Result = JsonErrorResult(ex);
            }
            else
            {
                ViewBag.Exception = ex;
                filterContext.Result = View("Error");
            }
        }
    }
}