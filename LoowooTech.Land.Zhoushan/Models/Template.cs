﻿using LoowooTech.Land.Zhoushan.Common;
using NPOI.SS.UserModel;
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
        public Template(ISheet sheet)
        {
            Fields = new List<Field>();
            var cells = sheet.ReadData();
            foreach (var cell in cells)
            {
                if (cell.Value == null)
                    continue;
                AddFields(cell);
            }
        }

        public List<Field> Fields { get; private set; }

        /// <summary>
        /// 从Excel里读取记录
        /// </summary>
        /// <param name="list"></param>
        public bool TryReadData(List<ExcelCell> list)
        {
            var count = 0;
            foreach (var field in Fields)
            {
                field.Value = null;
                var cell = list.FirstOrDefault(e => e.Row == field.Cell.Row && e.Column == field.Cell.Column);
                if (cell != null)
                {
                    count++;
                    field.Value = cell.Value;
                }
            }
            return count > 0;
        }

        public void WriteData(List<ExcelCell> list)
        {
            foreach (var cell in list)
            {
                foreach (var field in Fields.Where(e => e.Cell.Row == cell.Row && e.Cell.Column == cell.Column))
                {
                    if (field.Parameters.Count > 0)
                    {
                        if (field.Template != cell.Value.ToString())
                        {
                            if (field.Value != null)
                            {
                                cell.Value = cell.Value.ToString().Replace(field.Template, field.Value.ToString());
                            }
                        }
                        else
                        {
                            cell.Value = field.Value;
                        }
                    }
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

        public object Value { get; set; }

        public string Template { get; set; }

        public ExcelCell Cell { get; set; }

        public List<FieldParameter> Parameters { get; set; }

        public void UpdateParameters(List<Field> fields)
        {
            if (!HasPrameter(FieldType.Value) && !HasPrameter(FieldType.RateValue))
            {
                return;
            }

            var hasFind = false;
            //想上查询，如果碰到条件字段，看字段是否覆盖(colspan)，查询完毕后继续查询，如果是value则break
            var upFields = fields.Where(e => e.Cell.Row < Cell.Row && e.IncludeColumn(Cell.Column)).OrderByDescending(e => e.Cell.Row);
            foreach (var f in upFields)
            {
                //如果是第一次碰到值列，跳过，如是第二次碰到，则停止搜寻
                if (f.HasPrameter(FieldType.Value) || f.HasPrameter(FieldType.RateValue))
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
                if (f.HasPrameter(FieldType.Value) || f.HasPrameter(FieldType.RateValue))
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
                else if (p.Type != FieldType.Hidden)
                {
                    Parameters.Add(p);
                }
            }
        }

        public bool HasPrameter(FieldType type)
        {
            return Parameters.Any(e => e.Type == type);
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
        /// <summary>
        /// 当前季度
        /// </summary>
        Quarter,
        /// <summary>
        /// 季度合计：{Quarters=3}统计前三个季度
        /// </summary>
        Quarters,
        /// <summary>
        /// 值类型
        /// </summary>
        Type,
        Area,
        Value,
        Year,
        LastYear,
        RateValue,
        /// <summary>
        /// 指定是同比还是环比
        /// </summary>
        Rate,
        /// <summary>
        /// 值的单位比率
        /// </summary>
        Unit,
        /// <summary>
        /// 是否隐藏
        /// </summary>
        Hidden,
        /// <summary>
        /// 本期=0、期末=1、期内增加=2、期内减少=3
        /// </summary>
        Period,
    }
}
