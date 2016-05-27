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
        private static readonly string CacheKey = "templates";

        public Template GetTemplate(Form form)
        {
            var cells = ExcelHelper.ReadData(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Templates", form.Name + ".xlsx"));
            var template = new Template();
            foreach (var cell in cells)
            {
                if (string.IsNullOrEmpty(cell.Value.ToString()))
                {
                    continue;
                }
                template.Fields.Add(new Field(cell));
            }
            template.UpdateFieldParameters();
            return template;
        }


        /// <summary>
        /// 把Template的Field中的Value数据写入数据库
        /// </summary>
        public void WriteData(int year, Quarter quarter, List<ExcelCell> data, Template template)
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
    }

    internal static class FieldExtension
    {
        public static NodeValue GetEntity(this Field field, IQueryable<NodeValue> query, int year, Quarter quarter)
        {
            foreach (var parameter in field.Parameters)
            {
                var hasYear = false;
                var hasQuarter = false;
                switch (parameter.Type)
                {
                    case FieldType.Area:
                        query = query.Where(e => e.AreaID == parameter.Value);
                        break;
                    case FieldType.Node:
                        query = query.Where(e => e.NodeID == parameter.Value);
                        break;
                    case FieldType.Quarter:
                        hasQuarter = true;
                        query = query.Where(e => e.Quarter == (Quarter)parameter.Value);
                        break;
                    case FieldType.Type:
                    case FieldType.Value:
                        query = query.Where(e => e.TypeID == parameter.Value);
                        break;
                    case FieldType.Year:
                        hasYear = true;
                        query = query.Where(e => e.Year == parameter.Value);
                        break;
                }
                if (!hasYear)
                {
                    query = query.Where(e => e.Year == year);
                }
                if (!hasQuarter)
                {
                    query = query.Where(e => e.Quarter == quarter);
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

            entity.Value = double.Parse(field.Value);
        }

    }
}
