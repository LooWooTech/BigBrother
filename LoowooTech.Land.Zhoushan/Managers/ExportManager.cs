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
    public class ExportManager : ManagerBase
    {
        public Stream ExportStatistics(int year, Quarter[] quarters)
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

        public Stream ExportFormStatistic(Form form, int year, Quarter[] quarters)
        {
            var excel = GetFormExcel(form, year, quarters);
            return GetExcelStream(excel);
        }

        public Stream ExportTrend(int year, Quarter[] quarters)
        {
            var doc = WordHelper.CreateDoc("templates/资源形势模板.docx");
            doc.WriteTitle(year + "年" + Core.TemplateManager.GetQuartersDescription(quarters) + "国土资源主要指标走势", "2");
            foreach (var form in Core.FormManager.GetForms())
            {
                var parameter = new NodeValueParameter
                {
                    FormID = form.ID,
                    Year = year,
                    Quarters = quarters,
                    GetNode = false,
                    GetArea = false,
                    GetValueType = true,
                };
                var values = Core.FormManager.GetNodeValues(parameter);
                var nodes = Core.FormManager.GetRootNodes(form.ID);
                doc.WriteTitle(form.Name, "3", NPOI.XWPF.UserModel.ParagraphAlignment.LEFT);
                var sb = new StringBuilder();
                foreach (var node in nodes)
                {
                    var nodeContent = GenerateContent(node, values);
                    if (nodeContent.Length > 0)
                    {
                        sb.Append(nodeContent.Trim('；').Replace("，，", "，") + "。");
                    }
                }


                doc.WriteContent(sb.ToString());
            }

            return doc.GetStream();
        }

        private string GenerateContent(Node node, IEnumerable<NodeValue> values)
        {
            var sb = new StringBuilder();
            var vals = values.Where(e => e.NodeID == node.ID);
            if (vals.Count() == 0 && node.NodeValueTypes.Length > 0)
            {
                return sb.ToString();
            }

            var unit = new StringBuilder();
            foreach (var val in vals)
            {
                if (val.RawValue == 0 && val.RateValue == 0)
                {
                    continue;
                }
                unit.Append(val.Type.Name);
                unit.Append(val.RawValue.ToString("f2").TrimEnd('0').TrimEnd('.'));
                unit.Append(val.Type.Unit);
                unit.Append("，同比");
                unit.Append(val.RateValue > 0 ? "增加" : "减少");
                unit.Append(val.RateValue);
                unit.Append("%；");
            }
            if (unit.Length > 0)
            {
                sb.Append(node.Name);
                sb.Append(unit.ToString());
            }
            if (node.Children.Count > 0)//todo
            {
                var children = new StringBuilder();
                foreach (var child in node.Children)
                {
                    children.Append(GenerateContent(child, values));
                }
                if (children.Length > 0)
                {
                    sb.Append("其中");
                    sb.Append(children.ToString());
                }
            }
            return sb.ToString();
        }
    }
}
