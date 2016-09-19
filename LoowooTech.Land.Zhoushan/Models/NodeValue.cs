using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("node_value")]
    public class NodeValue
    {
        public NodeValue()
        {
            UpdateTime = DateTime.Now;
        }

        public NodeValue(NodeValueParameter parameter)
        {
            AreaID = parameter.AreaID.Value;
            NodeID = parameter.NodeID;
            Year = parameter.Year;
            Quarter = parameter.Quarter;
            TypeID = parameter.TypeID;
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public int NodeID { get; set; }

        /// <summary>
        /// 手工录入的值，该值会影响到子区域的自动计算
        /// </summary>
        public double Value { get; set; }

        /// <summary>
        /// 导入和参与报表计算的真实的值
        /// </summary>
        [Column("raw_value")]
        public double RawValue { get; set; }

        /// <summary>
        /// 值类型（面积、金额、件数）
        /// </summary>
        public int TypeID { get; set; }

        /// <summary>
        /// 年度
        /// </summary>
        public int Year { get; set; }

        /// <summary>
        /// 季度
        /// </summary>
        public Quarter Quarter { get; set; }

        /// <summary>
        /// 地区
        /// </summary>
        public int AreaID { get; set; }

        [NotMapped]
        public Node Node { get; set; }

        [NotMapped]
        public NodeValueType Type { get; set; }

        [NotMapped]
        public Area Area { get; set; }

        public DateTime UpdateTime { get; set; }

        [NotMapped]
        public double RateValue
        {
            get
            {
                return MathHelper.GetRateValue(RawValue, CompareValue);
            }
        }

        [NotMapped]
        public double CompareValue { get; set; }
    }
}
