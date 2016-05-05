using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("Node")]
    public class NodeValue
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string NodeID { get; set; }

        public double Value { get; set; }

        public int NodeValueTypeID { get; set; }

        public NodeValueTime Time { get; set; }

        public int AreaID { get; set; }
    }
}
