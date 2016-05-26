using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public class Template
    {
        public Template()
        {
            Fields = new List<Field>();
        }

        public List<Field> Fields { get; set; }

        public void UpdateFieldParameters()
        {
            foreach (var field in Fields)
            {
                field.UpdateParameters(Fields);
            }
        }
    }

    public class Field
    {
        /// <summary>
        /// {Value=1 Node=1 Area=1 Quater=1}
        /// </summary>
        private static Regex CellValueRegex = new Regex(@"[^={\s]+=[^\s}]+", RegexOptions.Compiled);
        public Field(ExcelCell cell)
        {
            Cell = cell;
            Parameters = new List<FieldParameter>();
            var val = cell.Value.ToString();
            var startIndex = val.IndexOf('{');
            var endIndex = val.LastIndexOf('}');
            if (startIndex > -1 && endIndex > -1)
            {
                Template = val.Substring(startIndex, endIndex - startIndex + 1);
                foreach (Match m in CellValueRegex.Matches(Template))
                {
                    Parameters.Add(new FieldParameter(m.Groups[0].Value));
                }
            }
            else
            {
                Template = val;
            }
        }

        public string Value { get; set; }

        public string Template { get; set; }

        public ExcelCell Cell { get; set; }

        public List<FieldParameter> Parameters { get; set; }

        public void UpdateParameters(List<Field> fields)
        {
            if (!IsValueField)
            {
                return;
            }

            var hasFind = false;
            //想上查询，如果碰到条件字段，看字段是否覆盖(colspan)，查询完毕后继续查询，如果是value则break
            var upFields = fields.Where(e => e.Cell.Row < Cell.Row && e.IncludeColumn(Cell.Column)).OrderByDescending(e => e.Cell.Row);
            foreach (var f in upFields)
            {
                //如果是第一次碰到值列，跳过，如是第二次碰到，则停止搜寻
                if (f.IsValueField)
                {
                    if (hasFind)
                        break;
                    else
                        continue;
                }
                else
                {
                    if(f.Parameters.Count>0)
                    {
                        hasFind = true;
                    }
                    Parameters.AddRange(f.Parameters);
                }
            }
            hasFind = false;
            var leftFields = fields.Where(e => e.Cell.Column < Cell.Column && e.IncludRow(Cell.Row)).OrderByDescending(e => e.Cell.Column);
            foreach (var f in leftFields)
            {
                if (f.IsValueField)
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
                    Parameters.AddRange(f.Parameters);
                }
            }
        }

        public bool IsValueField
        {
            get
            {
                return Parameters.Any(e => e.Type == FieldType.Value || e.Type == FieldType.RateValue);
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
        public FieldParameter(string template)
        {
            var str = template.Split('=');
            FieldType type;
            Enum.TryParse(str[0], out type);
            Type = type;

            Value = int.Parse(str[1]);
        }

        public FieldType Type { get; set; }

        public int Value { get; set; }
    }

    public enum FieldType
    {
        Form,
        Node,
        Quarter,
        Type,
        Area,
        Value,
        RateValue
    }
}
