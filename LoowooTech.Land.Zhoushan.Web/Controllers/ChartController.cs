using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class ChartController : ControllerBase
    {
        public ActionResult Index(int formId, NodeValueParameter parameter = null)
        {
            ViewBag.Form = Core.FormManager.GetForm(formId);
            if (parameter.NodeID == 0)
            {
                var nodes = Core.FormManager.GetNodes(formId);
                var firstNode = nodes.Where(e => e.ParentID == 0).FirstOrDefault();
                parameter = new NodeValueParameter
                {
                    NodeID = firstNode.ID,
                    Year = DateTime.Now.Year,
                    RateType = RateType.YearOnYear,
                    Quarter = (Quarter)DateTime.Now.GetQuarter()
                };
            }
            ViewBag.Parameter = parameter;

            ViewBag.ChildValues = Core.FormManager.GetChildNodeValues(parameter);

            ViewBag.QuarterValues = Core.FormManager.GetQuarterNodeValues(parameter);

            ViewBag.AreaValues = Core.FormManager.GetAreaNodeValues(parameter);

            ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);

            return View();
        }

        public ActionResult NodeDropdown(int formId, int nodeId = 0)
        {
            ViewBag.NodeID = nodeId;
            ViewBag.Nodes = Core.FormManager.GetNodes(formId);
            return View();
        }
    }
}