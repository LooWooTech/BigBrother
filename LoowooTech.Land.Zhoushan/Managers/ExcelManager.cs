using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class ExcelManager : ManagerBase
    {
        public Stream ExportAllForms(int year, Quarter[] quarters)
        {
            var book = new HSSFWorkbook();
            var forms = Core.FormManager.GetForms();
            foreach (var form in forms)
            {
                var formExcel = (HSSFWorkbook)GetFormExcel(form, year, quarters);
                var sheet = (HSSFSheet)formExcel.CloneSheet(0);
                sheet.CopyTo(book, form.Name, true, true);
            }
            return GetExcelStream(book);
        }

        private static Stream GetExcelStream(IWorkbook workbook)
        {
            var result = new MemoryStream();
            workbook.Write(result);
            return result;
        }

        public IWorkbook GetFormExcel(Form form, int year, Quarter[] quarters)
        {
            var templateName = form.GetExportTemplate(quarters);
            var template = new Template(templateName);
            var excelData = Core.TemplateManager.WriteDbDataToExcel(form, year, quarters, template);
            return ExcelHelper.GetWorkbook(template.FilePath, excelData, 0);
        }

        public Stream ExportForm(Form form, int year, Quarter[] quarters)
        {
            var excel = GetFormExcel(form, year, quarters);
            return GetExcelStream(excel);
        }
    }
}
