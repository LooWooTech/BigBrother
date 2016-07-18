using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
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

        [Column("ValueTypes")]
        public string ValueTypes { get; set; }

        [NotMapped]
        public int[] NodeValueTypes
        {
            get
            {
                return (ValueTypes ?? string.Empty).Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(str => int.Parse(str)).ToArray();
            }
        }

        private string _importTemplate;

        public string ImportTemplate
        {
            get
            {
                return _importTemplate = _importTemplate ?? Name;
            }
            set
            {
                _importTemplate = value;
            }
        }

        private string _exportTemplate;
        public string ExportTemplate
        {
            get
            {
                return _exportTemplate = _exportTemplate ?? Name;
            }
            set
            {
                _exportTemplate = value;
            }
        }
    }
}
