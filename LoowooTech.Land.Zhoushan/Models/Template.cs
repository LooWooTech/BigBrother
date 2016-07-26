using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public class Template
    {
        public Template(string formName)
        {
            Fields = new List<Field>();
            var filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Templates", formName + ".xlsx");
            var cells = ExcelHelper.ReadData(filePath);
            foreach (var cell in cells)
            {
                if (cell.Value == null)
                    continue;
                AddFields(cell);
            }
            FilePath = filePath;
        }

        public string FilePath { get; private set; }

        public List<Field> Fields { get; private set; }

        /// <summary>
        /// 从Excel里读取记录
        /// </summary>
        /// <param name="list"></param>
        public void ReadData(List<ExcelCell> list)
        {
            foreach (var field in Fields)
            {
                field.Value = null;
                var cell = list.FirstOrDefault(e => e.Row == field.Cell.Row && e.Column == field.Cell.Column);
                if (cell != null)
                {
                    field.Value = cell.Value.ToString();
                }
            }
        }

        public void WriteData(List<ExcelCell> list)
        {
            foreach (var cell in list)
            {
                foreach (var field in Fields.Where(e => e.Cell.Row == cell.Row && e.Cell.Column == cell.Column))
                {
                    cell.Value = field.Parameters.Count > 0 ? field.GetReplacedValue() : cell.Value;
                }
            }
        }

        private static Regex FieldRegex = new Regex(@"\{(\w+(=\d+)?\s?)+\}", RegexOptions.Compiled);

        public void AddFields(ExcelCell cell)
        {
            foreach (Match m in FieldRegex.Matches(cell.Value.ToString()))
            {
                var field = new Field(m.Groups[0].Value, cell);
                field.UpdateParameters(Fields);
                Fields.Add(field);
            }
        }
    }

    public class Field
    {
        /// <summary>
        /// {Value=1 Node=1 Area=1 Quater=1}
        /// </summary>
        private static Regex CellValueRegex = new Regex(@"\w+(=\d+)?", RegexOptions.Compiled);

        public Field(string template, ExcelCell cell)
        {
            Cell = cell;
            Parameters = new List<FieldParameter>();
            Template = template;
            foreach (Match m in CellValueRegex.Matches(Template))
            {
                Parameters.Add(new FieldParameter(m.Groups[0].Value));
            }
        }

        public string Value { get; set; }

        public string Template { get; set; }

        public ExcelCell Cell { get; set; }

        public List<FieldParameter> Parameters { get; set; }

        public string GetReplacedValue()
        {
            return Cell.Value.ToString().Replace(Template, Value.TrimEnd('0').TrimEnd('.'));
        }

        public void UpdateParameters(List<Field> fields)
        {
            if (!IsValueField && !IsRateField)
            {
                return;
            }

            var hasFind = false;
            //想上查询，如果碰到条件字段，看字段是否覆盖(colspan)，查询完毕后继续查询，如果是value则break
            var upFields = fields.Where(e => e.Cell.Row < Cell.Row && e.IncludeColumn(Cell.Column)).OrderByDescending(e => e.Cell.Row);
            foreach (var f in upFields)
            {
                //如果是第一次碰到值列，跳过，如是第二次碰到，则停止搜寻
                if (f.IsValueField || f.IsRateField)
                {
                    if (hasFind)
                        break;
                    else
                        continue;
                }
                else
                {
                    if (f.Parameters.Count > 0)
                    {
                        hasFind = true;
                    }
                    AddParameters(f.Parameters);
                }
            }
            hasFind = false;
            var leftFields = fields.Where(e => e.Cell.Column < Cell.Column && e.IncludRow(Cell.Row)).OrderByDescending(e => e.Cell.Column);
            foreach (var f in leftFields)
            {
                if (f.IsValueField || f.IsRateField)
                {
                    if (hasFind)
                        break;
                    else
                        continue;
                }
                else
                {
                    if (f.Parameters.Count > 0)
                    {
                        hasFind = true;
                    }
                    AddParameters(f.Parameters);
                }
            }
        }

        internal void SetParameter(FieldType type, int value)
        {
            var p = Parameters.FirstOrDefault(e => e.Type == type);
            if (p == null)
            {
                Parameters.Add(new FieldParameter(type, value));
            }
            else if (p.Value == 0)
            {
                p.Value = value;
            }
        }

        private void AddParameters(List<FieldParameter> parameters)
        {
            //如果已存在的参数，则不再添加（以最下最右为主）
            foreach (var p in parameters)
            {
                var p1 = Parameters.FirstOrDefault(e => e.Type == p.Type);
                if (p1 != null)
                {
                    if (p.Value == 0 && p1.Value > 0)
                        p.Value = p1.Value;
                }
                else if(p.Type != FieldType.Hidden)
                {
                    Parameters.Add(p);
                }
            }
        }

        public bool IsValueField
        {
            get
            {
                return Parameters.Any(e => e.Type == FieldType.Value);
            }
        }

        public bool IsRateField
        {
            get
            {
                return Parameters.Any(e => e.Type == FieldType.RateValue);
            }
        }

        public bool IsHiddenField
        {
            get
            {
                return Parameters.Any(e => e.Type == FieldType.Hidden);
            }
        }

        /// <summary>
        /// 是否包含某列
        /// </summary>
        public bool IncludeColumn(int column)
        {
            return Cell.Column == column || (column > Cell.Column && column <= (Cell.Column + Cell.Colspan - 1));
        }
        /// <summary>
        /// 是否包含某行
        /// </summary>
        public bool IncludRow(int row)
        {
            return Cell.Row == row || (row > Cell.Row && row <= (Cell.Row + Cell.Rowspan - 1));
        }

    }

    public class FieldParameter
    {
        public FieldParameter(FieldType type, int value)
        {
            Type = type;
            Value = value;
        }

        public FieldParameter(string template)
        {
            var str = template.Split('=');
            FieldType type;
            Enum.TryParse(str[0], true, out type);
            Type = type;
            if (str.Length == 2)
            {
                Value = int.Parse(str[1]);
            }
        }

        public FieldType Type { get; set; }

        public int Value { get; set; }
    }

    public enum FieldType
    {
        Form = 1,
        Node,
        Quarter,
        /// <summary>
        /// 举例：{Quarters=3}统计前三个季度
        /// </summary>
        Quarters,
        Type,
        Area,
        Value,
        Year,
        RateValue,
        /// <summary>
        /// 指定是同比还是环比
        /// </summary>
        Rate,
        Hidden
    }
}
