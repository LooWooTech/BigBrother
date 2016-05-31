using LoowooTech.Land.Zhoushan.Caching;
using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using NPOI.HSSF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Caching;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class TemplateManager : ManagerBase
    {
        /// <summary>
        /// 把Template的Field中的Value数据写入数据库
        /// </summary>
        public void WriteExcelDataToDb(int year, Quarter quarter, List<ExcelCell> data, Template template)
        {
            template.ReadData(data);
            using (var db = GetDbContext())
            {
                foreach (var field in template.Fields)
                {
                    if (!field.IsValueField) continue;
                    var query = db.NodeValues.AsQueryable();
                    var entity = field.GetEntity(query, year, quarter);
                    if (entity == null)
                    {
                        entity = new NodeValue();
                        field.SetEntity(entity, year, quarter);
                        db.NodeValues.Add(entity);
                    }
                    else
                    {
                        field.SetEntity(entity, year, quarter);
                    }
                }
                db.SaveChanges();
            }
        }

        public List<ExcelCell> WriteDbDataToExcel(Form form, int year, Quarter quarter, Template template)
        {
            using (var db = GetDbContext())
            {
                var result = new List<ExcelCell>();
                var areas = Core.AreaManager.GetAreas();

                foreach (var field in template.Fields)
                {
                    if (field.Parameters.Count > 0)
                    {
                        var firstParameter = field.Parameters[0];
                        switch (firstParameter.Type)
                        {
                            case FieldType.Form:
                                field.Value = form.Name;
                                break;
                            case FieldType.Area:
                                var area = Core.AreaManager.GetArea(firstParameter.Value);
                                field.Value = area == null ? "未知区域" : area.Name;
                                break;
                            case FieldType.Node:
                                var node = Core.FormManager.GetNode(firstParameter.Value);
                                field.Value = node == null ? "未知分类" : node.Name;
                                break;
                            case FieldType.Quarter:
                                field.Value = (firstParameter.Value == 0 ? (int)quarter : firstParameter.Value).ToString();
                                break;
                            case FieldType.Type:
                                var valueType = Core.FormManager.GetNodeValueType(firstParameter.Value);
                                field.Value = valueType == null ? "未知类型" : valueType.Name + "(" + valueType.Unit + ")";
                                break;
                            case FieldType.Year:
                                field.Value = firstParameter.Value == 0 ? year.ToString() : firstParameter.Value.ToString();
                                break;
                            case FieldType.Value:
                            case FieldType.RateValue:
                                var query = db.NodeValues.AsQueryable();
                                var entity = field.GetEntity(query, year, quarter) ?? new NodeValue();
                                field.Value = (firstParameter.Type == FieldType.Value ? entity.Value : entity.RateValue).ToString("f2");
                                break;
                        }
                    }
                    result.Add(field.Cell);
                }

                template.WriteData(result);
                return result;
            }
        }
    }

    internal static class FieldExtension
    {
        public static NodeValue GetEntity(this Field field, IQueryable<NodeValue> query, int year, Quarter quarter)
        {
            var hasYear = false;
            var hasQuarter = false;
            foreach (var parameter in field.Parameters)
            {
                switch (parameter.Type)
                {
                    case FieldType.Area:
                        query = query.Where(e => e.AreaID == parameter.Value);
                        break;
                    case FieldType.Node:
                        query = query.Where(e => e.NodeID == parameter.Value);
                        break;
                    case FieldType.Quarter:
                        if (parameter.Value > 0)
                        {
                            hasQuarter = true;
                            query = query.Where(e => e.Quarter == (Quarter)parameter.Value);
                        }
                        break;
                    case FieldType.Type:
                    case FieldType.Value:
                        query = query.Where(e => e.TypeID == parameter.Value);
                        break;
                    case FieldType.Year:
                        if (parameter.Value > 0)
                        {
                            hasYear = true;
                            query = query.Where(e => e.Year == parameter.Value);
                        }
                        break;
                }
            }
            if (!hasYear)
            {
                query = query.Where(e => e.Year == year);
            }
            if (!hasQuarter)
            {
                query = query.Where(e => e.Quarter == quarter);
            }
            return query.FirstOrDefault();
        }

        public static void SetEntity(this Field field, NodeValue entity, int year = 0, Quarter quarter = 0)
        {
            foreach (var parameter in field.Parameters)
            {
                switch (parameter.Type)
                {
                    case FieldType.Area:
                        entity.AreaID = parameter.Value;
                        break;
                    case FieldType.Node:
                        entity.NodeID = parameter.Value;
                        break;
                    case FieldType.Quarter:
                        entity.Quarter = (Quarter)parameter.Value;
                        break;
                    case FieldType.Type:
                    case FieldType.Value:
                        entity.TypeID = parameter.Value;
                        break;
                    case FieldType.Year:
                        entity.Year = parameter.Value;
                        break;
                }
            }
            if (entity.Year == 0) entity.Year = year;
            if (entity.Quarter == 0) entity.Quarter = quarter;

            entity.Value = double.Parse(field.Value);
        }

    }
}
