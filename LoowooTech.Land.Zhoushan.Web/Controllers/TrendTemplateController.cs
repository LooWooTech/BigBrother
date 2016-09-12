using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    [UserRoleFilter(Models.UserRole.Advanced)]
    public class TrendTemplateController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.List = Core.TrendTemplateManager.GetList();
            return View();
        }

        [HttpGet]
        public ActionResult Edit(int id = 0)
        {
            ViewBag.Forms = Core.FormManager.GetForms(CurrentIdentity.FormIds);
            ViewBag.Model = Core.TrendTemplateManager.GetModel(id) ?? new TrendTemplate();
            return View();
        }

        [HttpPost]
        public void Save(TrendTemplate data)
        {
            if (string.IsNullOrEmpty(data.Name) || string.IsNullOrEmpty(data.FilePath))
            {
                throw new ArgumentException("没有上传模板文件");
            }
            if (data.FormID == 0)
            {
                throw new Exception("请选择表单");
            }
            Core.TrendTemplateManager.Save(data);
        }

        public void Delete(int id)
        {
            Core.TrendTemplateManager.Delete(id);
        }

        public ActionResult Upload(string inputName = null)
        {
            var file = Request.Files[inputName];
            if (file.ContentLength == 0)
            {
                throw new ArgumentException("请选择有效的文件");
            }
            var uploadDir = Request.MapPath("/TrendTemplates/");
            if (!Directory.Exists(uploadDir))
            {
                Directory.CreateDirectory(uploadDir);
            }

            file.SaveAs(uploadDir + "/" + file.FileName);

            return JsonSuccessResult(new { file = file.FileName });
        }
    }
}