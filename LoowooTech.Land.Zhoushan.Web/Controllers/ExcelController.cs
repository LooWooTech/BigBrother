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
    public class ExcelController : ControllerBase
    {
        [HttpGet]
        public ActionResult Import(int formId = 0)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form != null)
            {
                ViewBag.Form = form;
            }
            else
            {
                ViewBag.Forms = Core.FormManager.GetForms();
            }
            return View();
        }

        public ActionResult Upload(int formId)
        {
            if (Request.Files.Count == 0)
            {
                throw new ArgumentException("请选择上传文件");
            }
            var file = Request.Files[0];
            var filePath = "uploads/" + file.FileName;
            var savePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, filePath);
            Request.Files[0].SaveAs(savePath);
            return JsonSuccessResult(new { filePath });
        }

        [HttpPost]
        public ActionResult Import(int formId, int year, Quarter quarter, string filePath)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("没有找到该表单");
            }
            var template = Core.TemplateManager.GetTemplate(form);

            var excelData = ExcelHelper.ReadData(filePath);

            Core.TemplateManager.WriteData(year, quarter, excelData, template);

            return JsonSuccessResult();

        }
    }
}