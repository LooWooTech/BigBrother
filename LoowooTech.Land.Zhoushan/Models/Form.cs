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
        public Form()
        {
            Nodes = new List<Node>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public Node GetNode(int id)
        {
            return Nodes.FirstOrDefault(e => e.ID == id);
        }

        public string Name { get; set; }
        
        [NotMapped]
        public List<Node> Nodes { get; set; }
    }
}
