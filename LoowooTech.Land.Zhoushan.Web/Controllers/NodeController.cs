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
            ViewBag.Node = node ?? new Node { FormID = form.ID };
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
    }
}