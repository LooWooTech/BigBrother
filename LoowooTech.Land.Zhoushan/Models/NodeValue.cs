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
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public int NodeID { get; set; }

        public double Value { get; set; }

        public int TypeID { get; set; }

        public NodeValueTime TimeID { get; set; }

        public int AreaID { get; set; }

        [NotMapped]
        public NodeValueType Type { get; set; }

        [NotMapped]
        public Area Area { get; set; }
    }
}
