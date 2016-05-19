using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class NodeController : ControllerBase
    {
        public ActionResult Index(int formId)
        {
            var form = Core.FormManager.GetForm(formId);
            ViewBag.Form = form;
            ViewBag.Nodes = form.Nodes;

            return View();
        }

        [HttpGet]
        public ActionResult Edit(int formId = 0, int id = 0, int parentId = 0)
        {
            if (formId == 0 && id == 0 && parentId == 0)
            {
                throw new ArgumentException("参数错误");
            }
            Form form = null;
            Node node = null;
            Node parent = null;
            if (formId > 0)
            {
                form = Core.FormManager.GetForm(formId);
                node = new Node { FormID = form.ID };
            }
            else if (id > 0)
            {
                node = Core.FormManager.GetNode(id);
            }
            else if (parentId > 0)
            {
                parent = Core.FormManager.GetNode(parentId);
                node = new Node { FormID = parent.FormID, ParentID = parent.ID };
            }
            ViewBag.Model = node ?? new Node { FormID = form.ID };
            return View();
        }

        [HttpPost]
        public ActionResult Edit(Node model)
        {
            Core.FormManager.SaveNode(model);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            Core.FormManager.DeleteNode(id);
            return JsonSuccessResult();
        }

        public ActionResult ValueTypeDropdown(int typeId = 0)
        {
            ViewBag.TypeID = typeId;
            ViewBag.List = Core.FormManager.GetNodeValueTypes();
            return View();
        }

        public ActionResult Values(int nodeId, int? year, NodeValueTime? timeId, int? areaId, int? typeId)
        {
            var node = Core.FormManager.GetNode(nodeId);
            if (node == null)
            {
                throw new ArgumentException("参数错误，没有找到该分类");
            }
            Core.FormManager.GetNodeValues(node);
            ViewBag.Model = node;
            ViewBag.Year = year;
            ViewBag.TimeID = timeId;
            ViewBag.AreaID = areaId;
            ViewBag.TypeID = typeId;
            return View();
        }

        [HttpGet]
        public ActionResult EditValue(int nodeId = 0, int valueId = 0)
        {
            Node node = null;
            NodeValue model = null;
            if (nodeId > 0)
            {
                node = Core.FormManager.GetNode(nodeId);
                if (node == null)
                {
                    throw new ArgumentException("参数错误，没有找到该分类");
                }
            }
            else
            {
                model = Core.FormManager.GetNodeValue(valueId);
            }
            if (node == null && model == null)
            {
                throw new ArgumentException("参数错误");
            }
            ViewBag.Model = model ?? new NodeValue { NodeID = node.ID };
            return View();
        }

        [HttpPost]
        public ActionResult SaveValue(NodeValue data)
        {
            Core.FormManager.SaveNodeValue(data);

            return JsonSuccessResult();
        }

        public ActionResult DeleteValue(int valueId)
        {
            Core.FormManager.DeleteNodeValue(valueId);
            return JsonSuccessResult();
        }
    }
}