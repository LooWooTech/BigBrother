using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("form")]
    public class Form
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string Name { get; set; }

        public bool Disabled { get; set; }

        /// <summary>
        /// 该表单的node的值是否不包含子区域的合计
        /// </summary>
        public bool ExcludeSubArea { get; set; } = true;

        public string ImportTemplate { get; set; }

        public string ExportTemplate { get; set; }

        public string GetImportTemplate()
        {
            if (string.IsNullOrEmpty(ImportTemplate))
            {
                return Name;
            }
            var tempaltes = ImportTemplate.Replace("\r", "").Split('\n');
            return tempaltes[0];
        }

        public string GetExportTemplate(Quarter quarter)
        {
            if (string.IsNullOrEmpty(ExportTemplate))
            {
                return Name;
            }

            var tempaltes = ExportTemplate.Replace("\r", "").Split('\n');

            var templatePath = ExportTemplate.Replace("\r", "").Split('\n').FirstOrDefault(e => e.Contains("单季度"));
            if (string.IsNullOrEmpty(templatePath))
            {
                return tempaltes[0];
            }
            return templatePath;
        }

    }
}
