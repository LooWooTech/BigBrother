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
                    db.SaveChanges();
                }
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
                        if (field.IsHiddenField)
                        {
                            field.Value = string.Empty;
                            result.Add(field.Cell);
                            continue;
                        }

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
                                field.Value = ((int)quarter).ToString();
                                break;
                            case FieldType.Type:
                                var valueType = Core.FormManager.GetNodeValueType(firstParameter.Value);
                                field.Value = valueType == null ? "未知类型" : valueType.Name;
                                break;
                            case FieldType.Year:
                                field.Value = firstParameter.Value == 0 ? year.ToString() : firstParameter.Value.ToString();
                                break;
                            case FieldType.Value:
                                field.Value = field.GetSumValue(db.NodeValues.AsQueryable(), year, (int)quarter, e => e.Value).ToString("f2");
                                break;
                            case FieldType.RateValue:
                                field.Value = field.GetSumValue(db.NodeValues.AsQueryable(), year, (int)quarter, e => e.RateValue).ToString("f2");
                                break;
                            case FieldType.Quarters:
                                var quarters = new int[firstParameter.Value == 0 ? (int)quarter : firstParameter.Value];
                                for (var i = 1; i <= quarters.Length; i++)
                                {
                                    quarters[i - 1] = i;
                                }
                                field.Value = string.Join("-", quarters);
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
        public static double GetSumValue(this Field field, IQueryable<NodeValue> query, int year, int quarter, Func<NodeValue, double> getField)
        {
            field.SetParameter(FieldType.Area, 0);
            field.SetParameter(FieldType.Year, year);
            //如果当前字段是多季度累计
            if (field.Parameters.Any(e => e.Type == FieldType.Quarters))
            {
                field.SetParameter(FieldType.Quarters, quarter);
            }
            else
            {
                field.SetParameter(FieldType.Quarter, quarter);
            }

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
                            query = query.Where(e => e.Quarter == (Quarter)parameter.Value);
                        }
                        break;
                    case FieldType.Quarters:
                        {
                            var quarters = new Quarter[parameter.Value];
                            for (var i = 1; i <= parameter.Value; i++)
                            {
                                quarters[i - 1] = (Quarter)i;
                            }
                            query = query.Where(e => quarters.Contains(e.Quarter));
                        }
                        break;
                    case FieldType.Type:
                    case FieldType.Value:
                        query = query.Where(e => e.TypeID == parameter.Value);
                        break;
                    case FieldType.Year:
                        if (parameter.Value > 0)
                        {
                            query = query.Where(e => e.Year == parameter.Value);
                        }
                        break;
                }
            }
            return query.ToList().Select(e => getField(e)).Sum();
        }

        public static NodeValue GetEntity(this Field field, IQueryable<NodeValue> query, int year, Quarter quarter)
        {
            field.SetParameter(FieldType.Area, 0);
            field.SetParameter(FieldType.Year, year);
            field.SetParameter(FieldType.Quarter, (int)quarter);

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
                        query = query.Where(e => e.Quarter == (Quarter)parameter.Value);
                        break;
                    case FieldType.Type:
                    case FieldType.Value:
                        query = query.Where(e => e.TypeID == parameter.Value);
                        break;
                    case FieldType.Year:
                        query = query.Where(e => e.Year == parameter.Value);
                        break;
                }
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

            double val = 0;
            double.TryParse(field.Value, out val);
            entity.Value = val;
        }

    }
}
