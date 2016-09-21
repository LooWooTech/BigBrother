using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web
{
    public static class WebUtility
    {
        public static HtmlString Pagination(this HtmlHelper html, PageParameter page, string attributes = null)
        {
            return new PageView(html.ViewContext.HttpContext, page) { LinkAttributes = attributes }.GetHtml();
        }
    }
}
