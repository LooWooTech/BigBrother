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
            return View();
        }

        public ActionResult NodeChart(NodeValueParameter parameter)
        {
            ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
            ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
            ViewBag.ValueType = Core.FormManager.GetNodeValueType(parameter.TypeID) ?? new NodeValueType { ID = 0, Name = "-/-", Unit = "/" };
            ViewBag.ChildNodes = Core.FormManager.GetNodeChildren(parameter.NodeID);


            var nodes = Core.FormManager.GetNodeChildren(parameter.NodeID);

            var childIds = nodes.Select(e => e.ID).ToArray();
            parameter.NodeIds = childIds;
            parameter.GetNode = false;
            var list = Core.FormManager.GetNodeValues(parameter);
            foreach (var item in list)
            {
                item.Node = nodes.FirstOrDefault(e => e.ID == item.NodeID);
            }
            ViewBag.ChildValues = list;

            ViewBag.Parameter = parameter;
            return View();
        }

        public ActionResult QuarterChart(int yearLength, NodeValueParameter parameter)
        {
            var years = new List<int>();
            for (var i = 0; i < yearLength; i++)
            {
                years.Add(DateTime.Now.Year - i);
            }
            parameter.Years = years.ToArray();
            parameter.Quarters = new Quarter[] { Quarter.First, Quarter.Second, Quarter.Third, Quarter.Fourth };
            ViewBag.Parameter = parameter;
            parameter.RateType = null;
            ViewBag.Values = Core.FormManager.GetNodeValues(parameter);
            ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
            ViewBag.ValueType = Core.FormManager.GetNodeValueType(parameter.TypeID) ?? new NodeValueType { ID = 0, Name = "-/-", Unit = "/" };
            return View();
        }

        public ActionResult AreaChart(NodeValueParameter parameter)
        {
            var areas = Core.AreaManager.GetAreas(parameter.AreaID);
            var areaIds = areas.Select(e => e.ID).ToArray();
            parameter.AreaIds = areaIds;
            parameter.GetArea = false;
            parameter.AreaID = null;
            ViewBag.Parameter = parameter;
            var list = Core.FormManager.GetNodeValues(parameter);
            foreach (var item in list)
            {
                item.Area = areas.FirstOrDefault(e => e.ID == item.AreaID);
            }
            ViewBag.Areas = areas;
            ViewBag.Values = list;
            ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
            ViewBag.ValueType = Core.FormManager.GetNodeValueType(parameter.TypeID) ?? new NodeValueType { ID = 0, Name = "-/-", Unit = "/" };
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