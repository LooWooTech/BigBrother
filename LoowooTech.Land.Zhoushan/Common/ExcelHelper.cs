using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public class ExcelCell
    {
        public ExcelCell()
        {
            Rowspan = 1;
            Colspan = 1;
        }

        public int Row { get; set; }

        public int Column { get; set; }

        public int Rowspan { get; set; }

        public int Colspan { get; set; }

        public object Value { get; set; }
    }

    public class ExcelHelper
    {
        private static ExcelCell ConvertToExcelCell(ICell cell)
        {
            if (cell == null) return null;
            var result = new ExcelCell();
            //如果是合并的单元格，则需要计算该单元格的rowspan和colspan
            if (cell.IsMergedCell && cell.CellType != CellType.Blank)
            {
                //先向右查询
                for (var i = cell.ColumnIndex + 1; i < cell.Row.LastCellNum; i++)
                {
                    var c = cell.Row.GetCell(i);
                    if (c != null && c.IsMergedCell && c.CellType == CellType.Blank)
                    {
                        result.Colspan++;
                    }
                    else
                    {
                        break;
                    }
                }
                //向下查询
                for (var i = cell.RowIndex + 1; i < cell.Sheet.LastRowNum; i++)
                {
                    var row = cell.Sheet.GetRow(i);
                    if (row != null)
                    {
                        var c = row.GetCell(cell.ColumnIndex);
                        if (c != null && c.IsMergedCell && c.CellType == CellType.Blank)
                        {
                            result.Rowspan++;
                        }
                        else
                        {
                            break;
                        }
                    }
                    else
                    {
                        break;
                    }
                }
            }
            switch (cell.CellType)
            {
                case CellType.Numeric:
                    result.Value = cell.NumericCellValue;
                    break;
                default:
                    result.Value = cell.StringCellValue;
                    break;
            }
            result.Row = cell.RowIndex;
            result.Column = cell.ColumnIndex;
            return result;
        }

        public static List<ExcelCell> ReadData(string filePath, int sheetIndex = 0)
        {
            using (var fs = new FileStream(filePath, FileMode.Open))
            {
                var workbook = WorkbookFactory.Create(fs);
                var sheet = workbook.GetSheetAt(sheetIndex);
                var list = new List<ExcelCell>();
                for (var i = sheet.FirstRowNum; i <= sheet.LastRowNum; i++)
                {
                    var row = sheet.GetRow(i);
                    if (row == null) continue;
                    foreach (var cell in row.Cells)
                    {
                        if(cell.CellType == CellType.Blank)
                        {
                            continue;
                        }
                        var excelCell = ConvertToExcelCell(cell);
                        list.Add(excelCell);
                    }
                }
                return list;
            }
        }
    }
}
