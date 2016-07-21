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
        public ActionResult Index(int formId, NodeValueParameter parameter)
        {
            ViewBag.Form = Core.FormManager.GetForm(formId);
            ViewBag.Parameter = parameter;
            //获取可用年份
            ViewBag.Years = Core.FormManager.GetFormYears(formId);
            return View();
        }

        public ActionResult NodeChart(NodeValueParameter parameter)
        {
            parameter.Quarters = Request.QueryString["quarters"].Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();
            if (parameter.Quarters.Length < 2)
            {
                parameter.Quarter = parameter.Quarters[0];
                parameter.Quarters = null;
            }

            ViewBag.Form = Core.FormManager.GetForm(parameter.FormID);
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();

            //如果是查看某个分类的子类
            if (parameter.NodeID > 0)
            {
                ViewBag.CurrentNode = Core.FormManager.GetNode(parameter.NodeID);
                ViewBag.CurrentNodeValues = Core.FormManager.GetNodeValues(parameter);
            }

            var childNodes = parameter.NodeID == 0 ? Core.FormManager.GetRootNodes(parameter.FormID) : Core.FormManager.GetNodeChildren(parameter.NodeID);
            ViewBag.ChildNodes = childNodes;

            var childIds = childNodes.Select(e => e.ID).ToArray();
            parameter.NodeIds = childIds;
            var list = Core.FormManager.GetNodeValues(parameter);
            foreach (var item in list)
            {
                item.Node = childNodes.FirstOrDefault(e => e.ID == item.NodeID);
            }
            ViewBag.ChildValues = list;

            ViewBag.Parameter = parameter;
            return View();
        }

        public ActionResult QuarterChart(int formId, NodeValueParameter parameter)
        {
            ViewBag.CompareYear = Request.QueryString["quarters"] == "1,2,3,4";
            parameter.Quarters = new Quarter[] { Quarter.First, Quarter.Second, Quarter.Third, Quarter.Fourth };
            parameter.Years = Core.FormManager.GetFormYears(formId);
            ViewBag.Parameter = parameter;
            parameter.RateType = null;
            if (parameter.NodeID > 0)
            {
                ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
                ViewBag.Nodes = new List<Node> { Core.FormManager.GetNode(parameter.NodeID) };
            }
            else
            {
                var childNodes = Core.FormManager.GetRootNodes(formId);
                parameter.NodeIds = childNodes.Select(e => e.ID).ToArray();
                ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
                ViewBag.Nodes = childNodes;
            }
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        public ActionResult AreaChart(NodeValueParameter parameter)
        {
            if (parameter.NodeID == 0)
            {
                return View();
            }
            parameter.Quarters = Request.QueryString["quarters"].Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();
            if (parameter.Quarters.Length < 2)
            {
                parameter.Quarter = parameter.Quarters[0];
                parameter.Quarters = null;
            }

            var areas = Core.AreaManager.GetAreas(parameter.AreaID);
            var areaIds = areas.Select(e => e.ID).ToArray();
            parameter.AreaIds = areaIds;
            parameter.AreaID = null;
            ViewBag.Parameter = parameter;

            ViewBag.Areas = areas;
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
            ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
            return View();
        }

        public ActionResult NodeDropdown(int formId, int nodeId = 0)
        {
            ViewBag.NodeID = nodeId;
            ViewBag.Nodes = Core.FormManager.GetNodeRoots(formId);
            return View();
        }
    }
}