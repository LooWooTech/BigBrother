using LoowooTech.Land.Zhoushan.Common;
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
            ViewBag.Form = Core.FormManager.GetForm(formId);
            ViewBag.Nodes = Core.FormManager.GetNodes(formId);

            return View();
        }

        public ActionResult GetList(int formId)
        {
            var data = Core.FormManager.GetNodes(formId);
            return JsonSuccessResult(data);
        }

        [UserRoleFilter(UserRole.Branch)]
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
            ViewBag.Model = node = node ?? new Node { FormID = form.ID };
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            ViewBag.Nodes = Core.FormManager.GetNodes(node.FormID);
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        [HttpPost]
        public ActionResult Edit(Node model)
        {
            model.Validate();
            Core.FormManager.SaveNode(model);
            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult Delete(int id)
        {
            Core.FormManager.DeleteNode(id);
            return JsonSuccessResult();
        }

        public ActionResult ValueTypeDropdown(string ids, int typeId = 0, int nodeId = 0)
        {
            int[] valueTypeIds = null;
            if (nodeId > 0)
            {
                var node = Core.FormManager.GetNode(nodeId);
                valueTypeIds = node.NodeValueTypes;
            }
            else
            {
                ids = ids ?? string.Empty;
                valueTypeIds = ids.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(str => int.Parse(str)).ToArray();
            }
            ViewBag.TypeID = typeId;
            ViewBag.List = Core.FormManager.GetNodeValueTypes(valueTypeIds);
            return View();
        }

        public ActionResult Values(NodeValueParameter parameter)
        {
            var node = Core.FormManager.GetNode(parameter.NodeID);
            if (node == null)
            {
                throw new ArgumentException("参数错误，没有找到该分类");
            }
            node.Values = Core.FormManager.GetNodeValues(parameter);
            ViewBag.Model = node;
            ViewBag.Parameter = parameter;
            return View();
        }

        public ActionResult CanEdit(int? year, Quarter? quarter)
        {
            var result = CurrentIdentity.Role > UserRole.Advanced || (year.HasValue && quarter.HasValue && Core.SeasonManager.Exist(year.Value, quarter.Value));
            return Content(result ? "1" : "0");
        }

        [UserRoleFilter(UserRole.Branch)]
        [HttpGet]
        public ActionResult EditValues(int formId)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("参数错误，未找到该表单");
            }
            ViewBag.Form = form;
            ViewBag.Nodes = Core.FormManager.GetNodes(formId);
            ViewBag.ValueTypes = Core.FormManager.GetNodeValueTypes();
            ViewBag.Season = Core.SeasonManager.GetCurrentSeason();
            return View();
        }

        public ActionResult SaveValues(int formId, int year, Quarter quarter, int areaId, Period period, string data)
        {
            //判断用户是否可以保存当前年份、季度的数据
            var season = Core.SeasonManager.GetSeason(year, quarter);

            if (CurrentIdentity.Role <= UserRole.Advanced && (season == null || !season.Indate))
            {
                throw new HttpException(401, "当前时段不能添加表单数据");
            }

            var values = data.ToObject<List<NodeValue>>();

            Core.FormManager.SaveNodeValues(values);
            Core.FormManager.ComputeSumValue(formId, year, quarter, values);
            return JsonSuccessResult();
        }

        public ActionResult GetNodeValues(NodeValueParameter parameter)
        {
            if (CurrentIdentity.Role < UserRole.Advanced && parameter.AreaID == 0)
            {
                parameter.AreaID = CurrentIdentity.AreaIds.FirstOrDefault();
            }

            var list = Core.FormManager.GetNodeValues(parameter);

            return JsonSuccessResult(list);
        }

        [UserRoleFilter(UserRole.Branch)]
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
                model = new NodeValue { NodeID = node.ID };
            }
            else
            {
                model = Core.FormManager.GetNodeValue(valueId);
                node = Core.FormManager.GetNode(model.NodeID);
            }
            if (node == null && model == null)
            {
                throw new ArgumentException("参数错误");
            }
            ViewBag.Node = node;
            ViewBag.Model = model;
            return View();
        }

        [UserRoleFilter(UserRole.Branch)]
        [HttpPost]
        public ActionResult SaveValue(NodeValue data)
        {
            Core.FormManager.SaveNodeValue(data, false);

            return JsonSuccessResult();
        }

        [UserRoleFilter(UserRole.Branch)]
        public ActionResult DeleteValue(int valueId)
        {
            Core.FormManager.DeleteNodeValue(valueId);
            return JsonSuccessResult();
        }
    }
}