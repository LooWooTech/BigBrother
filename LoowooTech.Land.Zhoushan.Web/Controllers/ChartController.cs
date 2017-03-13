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
        public ActionResult Index(NodeValueParameter parameter)
        {
            if (parameter.FormID > 0)
            {
                ViewBag.Form = Core.FormManager.GetForm(parameter.FormID);
            }
            ViewBag.Forms = Core.FormManager.GetForms(CurrentIdentity.FormIds);
            ViewBag.Parameter = parameter;
            return View();
        }

        public ActionResult NodeChart([NodeValueParameterBinder]NodeValueParameter parameter)
        {
            ViewBag.Form = Core.FormManager.GetForm(parameter.FormID);
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();

            //如果是查看某个分类的子类
            if (parameter.NodeID > 0)
            {
                ViewBag.CurrentNode = Core.FormManager.GetNode(parameter.NodeID);
                ViewBag.CurrentNodeValues = Core.FormManager.GetNodeValues(parameter);
            }

            var childNodes = Core.FormManager.GetAllChildrenNodes(parameter.FormID, parameter.NodeID);
            ViewBag.ChildNodes = childNodes.Where(e => e.ParentID == parameter.NodeID).ToList();
            parameter.NodeIds = childNodes.Select(e => e.ID).ToArray();
            parameter.GetNode = false;
            parameter.GetArea = false;

            var list = Core.FormManager.GetNodeValues(parameter);
            foreach (var item in list)
            {
                item.Node = childNodes.FirstOrDefault(e => e.ID == item.NodeID);
            }
            ViewBag.ChildValues = list;
            ViewBag.Parameter = parameter;
            return View();
        }

        public ActionResult QuarterChart([NodeValueParameterBinder]NodeValueParameter parameter)
        {
            parameter.Years = Core.FormManager.GetFormYears(parameter.FormID);
            ViewBag.Parameter = parameter;
            parameter.RateType = null;
            parameter.Quarter = 0;
            if (parameter.NodeID > 0)
            {
                var node = Core.FormManager.GetNode(parameter.NodeID);
                var childNodes = Core.FormManager.GetNodeChildren(parameter.NodeID);
                var nodeIds = childNodes.Select(e => e.ID).ToList();
                nodeIds.Insert(0, node.ID);
                parameter.NodeIds = nodeIds.ToArray();

                childNodes.Insert(0, node);

                ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
                ViewBag.Nodes = childNodes;
            }
            else
            {
                var childNodes = Core.FormManager.GetRootNodes(parameter.FormID);
                parameter.NodeIds = childNodes.Select(e => e.ID).ToArray();
                ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
                ViewBag.Nodes = childNodes;
            }
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        public ActionResult AreaChart([NodeValueParameterBinder]NodeValueParameter parameter)
        {
            if (parameter.NodeID == 0)
            {
                return View();
            }

            var areas = Core.AreaManager.GetAreas();
            var areaIds = areas.Select(e => e.ID).ToArray();
            parameter.AreaIds = areaIds;
            parameter.AreaID = null;
            ViewBag.Parameter = parameter;

            ViewBag.Areas = areas.Where(e => e.ParentID == (parameter.AreaID ?? 0)).ToList();
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            ViewBag.AreaValues = Core.FormManager.GetNodeValues(parameter);
            ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
            return View();
        }

        public ActionResult NodeDropdown(int formId, int nodeId = 0)
        {
            ViewBag.NodeID = nodeId;
            ViewBag.Nodes = Core.FormManager.GetNodes(formId, 0);
            return View();
        }
    }
}