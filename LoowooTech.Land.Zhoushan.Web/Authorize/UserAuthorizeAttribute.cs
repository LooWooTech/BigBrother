using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LoowooTech.Land.Zhoushan.Web
{
    [AttributeUsage(AttributeTargets.All, Inherited = true)]
    public class UserAuthorizeAttribute : System.Web.Mvc.AuthorizeAttribute
    {
        public UserAuthorizeAttribute()
        {
            Enabled = true;
            LoginUrl = AppSettings.Current["LoginUrl"] ?? "/user/login";
        }

        public bool Enabled { get; set; }

        public string LoginUrl { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            return httpContext.User.Identity.IsAuthenticated;
        }


        protected override void HandleUnauthorizedRequest(System.Web.Mvc.AuthorizationContext filterContext)
        {
            if (Enabled)
            {
                var returnUrl = filterContext.HttpContext.Request.Url.AbsoluteUri;
                filterContext.HttpContext.Response.Redirect(LoginUrl + "?returnUrl=" + HttpUtility.UrlEncode(returnUrl));
            }
        }
    }
}