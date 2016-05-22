using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class ChatController : ControllerBase
    {
        public ActionResult Index(int formId, NodeValueParameter parameter)
        {
            ViewBag.Form = Core.FormManager.GetForm(formId);
            if (parameter != null)
            {
                ViewBag.Node = Core.FormManager.GetNode(parameter.NodeID);
                var values = Core.FormManager.GetNodeValues(parameter);
            }

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