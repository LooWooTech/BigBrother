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

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public int NodeID { get; set; }

        private double _value;
        public double Value
        {
            get
            {
                return _value == 0 ? RawValue : _value;
            }
            set
            {
                _value = value;
                if (value > 0 && RawValue == 0)
                {
                    RawValue = value;
                }
            }
        }

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
                var val = (RawValue == 0 ? Value : RawValue) - CompareValue;
                if (CompareValue == 0)
                {
                    if (val == 0) return 0;
                    return val > 0 ? 100 : -100;
                }
                return val / CompareValue * 100;
            }
        }

        [NotMapped]
        public double CompareValue { get; set; }
    }
}
