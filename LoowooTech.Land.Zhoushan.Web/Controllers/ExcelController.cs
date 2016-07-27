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
    [UserRoleFilter(UserRole.Branch)]
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

        [HttpPost]
        public ActionResult Import(int formId, int year, Quarter quarter, string filePath, string templateName)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("没有找到该表单");
            }

            //Core.FormManager.DeleteNodeValues(formId, year, quarter);

            var template = new Template(templateName);

            var excelData = ExcelHelper.ReadData(filePath);


            Core.TemplateManager.WriteExcelDataToDb(year, quarter, excelData, template);

            return JsonSuccessResult();

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

        [HttpGet]
        public ActionResult Export(int formId = 0)
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

        [HttpPost]
        public void Export(int formId, int year, Quarter quarter, string templateName)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("请选择一个报表");
            }
            var template = new Template(templateName);

            var excelData = Core.TemplateManager.WriteDbDataToExcel(form, year, quarter, template);

            using (var stream = ExcelHelper.WriteData(template.FilePath, excelData))
            {
                var fileName = form.Name + "-" + year + "-" + (int)quarter + ".xlsx";
                Response.ContentType = "application/vnd.ms-excel;charset=UTF-8";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(fileName)));
                Response.BinaryWrite(((MemoryStream)stream).GetBuffer());
                Response.End();
            }
        }
    }
}