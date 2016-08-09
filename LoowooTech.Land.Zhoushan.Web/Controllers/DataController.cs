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
        public void ExportStatistic(int formId, int year, string quarters, string type)
        {
            Quarter[] qs = quarters.Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();

            string fileName = null;
            Stream stream = null;
            if (formId == 0)
            {

                fileName = year + "年" + Core.TemplateManager.GetQuartersDescription(qs) + "统计报表.xls";
                stream = Core.ExportManager.ExportStatistics(year, qs);
            }
            else
            {
                var form = Core.FormManager.GetForm(formId);
                if (form == null)
                {
                    throw new ArgumentException("请选择一个报表");
                }

                stream = Core.ExportManager.ExportFormStatistic(form, year, qs);
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
        public void ExportTrend(int year,string quarters)
        {
            //导出word
            var qs = quarters.Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();
            var stream = Core.ExportManager.ExportTrend(year, qs);

            var fileName = year + "年" + Core.TemplateManager.GetQuartersDescription(qs) + "国土资源形势.doc";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(fileName)));
            Response.BinaryWrite(((MemoryStream)stream).GetBuffer());
            stream.Close();

            //导出excel（word的配图）

            //打包zip
        }

    }
}