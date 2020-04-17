using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using LoowooTech.Land.Zhoushan.Web.Security;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace LoowooTech.Land.Zhoushan.Web
{
    public static class AuthorizeHelper
    {
        private static readonly string TokenKey = ".zstoken";
        public static UserIdentity GetIdentity(this HttpContextBase context)
        {
            var token = context.Request[TokenKey] ?? context.Request.Headers[TokenKey];
            if (!string.IsNullOrWhiteSpace(token))
            {
                try
                {
                    var ticket = FormsAuthentication.Decrypt(token);
                    if (ticket != null && !string.IsNullOrEmpty(ticket.UserData))
                    {
                        return JsonConvert.DeserializeObject<UserIdentity>(ticket.UserData);
                    }
                }
                catch { }
            }
            return UserIdentity.Anonymouse;
        }
        public static void Login(this HttpContextBase context, User user)
        {
            var tokenValue = user.ToJson();
            var ticket = new FormsAuthenticationTicket(0, TokenKey, DateTime.Now, DateTime.Now.AddYears(1), false, tokenValue);
            var cookie = new HttpCookie(TokenKey, FormsAuthentication.Encrypt(ticket));
            context.Response.SetCookie(cookie);
        }

        public static void Logout(this HttpContextBase context)
        {
            var cookie = context.Request.Cookies.Get(TokenKey);
            if (cookie == null) return;
            cookie.Expires = DateTime.Now.AddYears(-1);
            cookie.Values.Remove(TokenKey);
            context.Response.SetCookie(cookie);
        }
    }
}