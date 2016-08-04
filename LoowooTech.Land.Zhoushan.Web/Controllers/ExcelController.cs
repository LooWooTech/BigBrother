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
        public ActionResult Import(int formId, int year, Quarter quarter, string filePath)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("没有找到该表单");
            }

            var template = new Template(form.GetImportTemplate());

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

        private string GetQuartersDescription(Quarter[] quarters)
        {
            switch (quarters.Length)
            {
                case 1:
                default:
                    return quarters[0].GetDescription();
                case 2:
                    return "上半年";
                case 3:
                    return "前三季度";
                case 4:
                    return "全年";
            }

        }

        [HttpPost]
        public void Export(int formId, int year, string quarters)
        {
            Quarter[] qs = quarters.Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();

            string fileName = null;
            Stream stream = null;
            if (formId == 0)
            {

                fileName = year + "年" + GetQuartersDescription(qs) + "统计报表.xls";
                stream = Core.ExcelManager.ExportAllForms(year, qs);
            }
            else
            {
                var form = Core.FormManager.GetForm(formId);
                if (form == null)
                {
                    throw new ArgumentException("请选择一个报表");
                }

                stream = Core.ExcelManager.ExportForm(form, year, qs);
                fileName = form.Name + "-" + year + "-" + GetQuartersDescription(qs) + ".xls";
            }
            Response.ContentType = "application/vnd.ms-excel;charset=UTF-8";
            Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(fileName)));
            Response.BinaryWrite(((MemoryStream)stream).GetBuffer());
            stream.Close();
        }
    }
}