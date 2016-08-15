using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class DataController : ControllerBase
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

            var sheet = ExcelHelper.GetSheet(Request.MapPath("/templates/" + form.GetImportTemplate() + ".xls"));

            var template = new Template(sheet);

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
            var savePath = Request.MapPath("/" + filePath);
            Request.Files[0].SaveAs(savePath);
            return JsonSuccessResult(new { filePath });
        }

        [HttpGet]
        public ActionResult ExportStatistic(int formId = 0)
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
        [UserRoleFilter(UserRole.City)]
        public void ExportStatistic(int formId, int year, string quarters, string type)
        {
            Quarter[] qs = quarters.Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();

            string fileName = null;
            Stream stream = null;
            if (formId == 0)
            {

                fileName = year + "年" + Core.TemplateManager.GetQuartersDescription(qs) + "统计报表.xls";
                stream = Core.ExportManager.ExportStatistics(year, qs, CurrentIdentity.AreaIds);
            }
            else
            {
                var form = Core.FormManager.GetForm(formId);
                if (form == null)
                {
                    throw new ArgumentException("请选择一个报表");
                }

                stream = Core.ExportManager.ExportFormStatistic(form, year, qs, CurrentIdentity.AreaIds);
                fileName = form.Name + "-" + year + "-" + Core.TemplateManager.GetQuartersDescription(qs) + ".xls";
            }
            Response.ContentType = "application/vnd.ms-excel;charset=UTF-8";
            Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(fileName)));
            Response.BinaryWrite(((MemoryStream)stream).GetBuffer());
            stream.Close();
        }

        [HttpGet]
        public ActionResult ExportTrend()
        {
            return View();
        }

        [HttpPost]
        [UserRoleFilter(UserRole.City)]
        public void ExportTrend(int year, string quarters)
        {
            var qs = quarters.Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();
            var name = year + "年" + Core.TemplateManager.GetQuartersDescription(qs) + "国土资源形势";

            //导出word
            var docStream = Core.ExportManager.ExportTrend(year, qs);

            //导出excel（word的配图）
            var excelStream = Core.ExportManager.ExportTrendCharts(year, qs, CurrentIdentity.AreaIds);

            using (var ms = new MemoryStream())
            {
                using (var zip = new ZipArchive(ms, ZipArchiveMode.Create))
                {
                    var doc = zip.CreateEntry(name + ".docx");
                    using (var sw = doc.Open())
                    {
                        sw.Write(((MemoryStream)docStream).GetBuffer(), 0, (int)docStream.Length);
                    }

                    var excel = zip.CreateEntry(name + "-图表.xlsx");
                    using (var sw = excel.Open())
                    {
                        sw.Write(((MemoryStream)excelStream).GetBuffer(), 0, (int)excelStream.Length);
                    }
                }
                Response.ContentType = "application/zip";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(name + ".zip")));
                Response.BinaryWrite(ms.GetBuffer());
            }
        }

    }
}