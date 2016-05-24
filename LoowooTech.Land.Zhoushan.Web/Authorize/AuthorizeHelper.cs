using LoowooTech.Land.Zhoushan.Models;
using LoowooTech.Land.Zhoushan.Web.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace LoowooTech.Land.Zhoushan.Web
{
    public class AuthorizeHelper
    {
        private static string _tokenKey = ".zsauth";

        public static UserIdentity GetIdentity(HttpContextBase context)
        {
            var token = context.Request.Headers[_tokenKey] ?? context.Request[_tokenKey];
            if (!string.IsNullOrEmpty(token))
            {
                var ticket = FormsAuthentication.Decrypt(token);
                if (ticket != null && !string.IsNullOrEmpty(ticket.Name))
                {
                    var values = ticket.Name.Split('|');
                    if (values.Length >= 3)
                    {
                        var userId = int.Parse(values[0]);
                        var name = values[1];
                        var role = Enum.Parse(typeof(UserRole), values[2]);
                        return new UserIdentity
                        {
                            ID = userId,
                            Name = name,
                            Role = (UserRole)role
                        };
                    }
                }
            }
            return UserIdentity.Anonymouse;
        }

        public static void Login(HttpContextBase context, User user)
        {
            var tokenValue = user.ID + "|" + user.Name + "|" + user.Role + "|" + DateTime.Now;
            var ticket = new FormsAuthenticationTicket(tokenValue, false, int.MaxValue);
            var cookie = new HttpCookie(_tokenKey, FormsAuthentication.Encrypt(ticket));
            cookie.Expires = DateTime.Now.AddDays(1);
            context.Response.SetCookie(cookie);
        }

        public static void Logout(HttpContextBase context)
        {
            var cookie = context.Request.Cookies.Get(_tokenKey);
            if (cookie == null) return;
            cookie.Expires = DateTime.Now.AddYears(-1);
            cookie.Values.Remove(_tokenKey);
            context.Response.SetCookie(cookie);
        }
    }
}