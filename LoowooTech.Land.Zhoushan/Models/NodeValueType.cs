using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("value_type")]
    public class NodeValueType
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string Name { get; set; }

        /// <summary>
        /// 单位之间的比率
        /// </summary>
        public int Ratio { get; set; }

        /// <summary>
        /// 单位名称从小到大 用逗号隔开，例如  亩,公顷
        /// </summary>
        [Column("Units")]
        public string Units { get; set; }

        [NotMapped]
        public string Unit
        {
            get
            {
                if (!string.IsNullOrEmpty(Units))
                {
                    return Units.Split(',')[0];
                }
                return null;
            }
        }
    }
}
