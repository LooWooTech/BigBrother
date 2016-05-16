using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("area")]
    public class Area
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string Name { get; set; }

        public int ParentID { get; set; }

        [NotMapped]
        public bool Checked { get; set; }

        [NotMapped]
        public int Level { get; set; }

        [NotMapped]
        public List<Area> Children { get; set; }

        public void GetChildren(List<Area> list)
        {
            Children = list.Where(e => e.ParentID == ID).ToList();
            foreach (var child in Children)
            {
                child.Level = Level + 1;
                child.GetChildren(list);
            }
        }
    }
}
