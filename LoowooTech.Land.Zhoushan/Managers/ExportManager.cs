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
        public Stream ExportStatistics(int[] formIds, int year, Quarter quarter, int[] areaIds)
        {
            var book = new HSSFWorkbook();
            var forms = Core.FormManager.GetForms(formIds);
            foreach (var form in forms)
            {
                var formExcel = (HSSFWorkbook)GetFormExcel(form, year, quarter, areaIds);
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

        public IWorkbook GetFormExcel(Form form, int year, Quarter quarter, int[] areaIds)
        {
            var templateName = form.GetExportTemplate(quarter);
            var sheet = ExcelHelper.GetSheet(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "templates", templateName + ".xls"));
            var template = new Template(sheet);
            var excelData = Core.TemplateManager.WriteDbDataToExcel(form, year, quarter, areaIds, template);
            sheet.WriteData(excelData);
            return sheet.Workbook;
        }

        public Stream ExportFormStatistic(Form form, int year, Quarter quarter, int[] areaIds)
        {
            var excel = GetFormExcel(form, year, quarter, areaIds);
            return GetExcelStream(excel);
        }

        public Stream ExportTrend(int year, Quarter quarter, int[] formIds)
        {
            var doc = WordHelper.CreateDoc("templates/资源形势模板.docx");
            doc.WriteTitle(year + "年" + quarter.GetDescription() + "国土资源主要指标走势", "2");
            foreach (var form in Core.FormManager.GetForms(formIds))
            {
                var parameter = new NodeValueParameter
                {
                    FormID = form.ID,
                    Year = year,
                    Quarter = quarter,
                    GetNode = false,
                    GetArea = false,
                    GetValueType = true,
                    RateType = RateType.YearOnYear,
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

        public Stream ExportTrendCharts(string templatePath, int year, Quarter quarter, int[] areaIds)
        {
            var sheet = ExcelHelper.GetSheet(templatePath);
            var template = new Template(sheet);
            var data = Core.TemplateManager.WriteDbDataToExcel(null, year, quarter, areaIds, template);
            sheet.WriteData(data);
            return GetExcelStream(sheet.Workbook);
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
            foreach (var kv in vals.GroupBy(v => v.Type).ToDictionary(g => g.Key, g => g.ToList()))
            {
                var type = kv.Key;
                var sumVal = kv.Value.Select(e => e.Value).DefaultIfEmpty(0).Sum();
                var sumComVal = kv.Value.Select(e => e.CompareValue).DefaultIfEmpty(0).Sum();
                var rateSumVal = MathHelper.GetRateValue(sumVal, sumComVal);
                if (sumVal == 0)
                {
                    continue;
                }
                if (!node.Name.EndsWith(type.Name))
                {
                    unit.Append(type.Name);
                }

                unit.Append(sumVal.ToString("f2").TrimEnd('0').TrimEnd('.'));
                unit.Append(type.Unit);
                unit.Append("，同比");
                unit.Append(rateSumVal > 0 ? "增加" : "减少");
                unit.Append(rateSumVal.ToString("f2").TrimEnd('0').TrimEnd('.'));
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
