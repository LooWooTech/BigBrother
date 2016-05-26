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

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class TemplateManager : ManagerBase
    {
        public Template GetTemplate(int formId)
        {
            var form = Core.FormManager.GetForm(formId);
            if (form == null)
            {
                throw new ArgumentException("没有找到该表单");
            }
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

    }
}
