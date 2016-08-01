using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("node")]
    public class Node
    {
        public Node()
        {
            Children = new List<Node>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public int FormID { get; set; }

        public int ParentID { get; set; }

        public string Name { get; set; }

        public string Group { get; set; }

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

        [NotMapped]
        public int Level { get; set; }

        [NotMapped]
        public bool Selected { get; set; }

        [NotMapped]
        public List<Node> Children { get; set; }

        [JsonIgnore]
        [NotMapped]
        public List<NodeValue> Values { get; set; }

        public void GetChildren(IEnumerable<Node> list)
        {
            Children = list.Where(e => e.ParentID == ID).ToList();
            foreach (var child in Children)
            {
                child.Level = Level + 1;
                child.GetChildren(list);
            }
        }

        public void Validate()
        {
            if (string.IsNullOrEmpty(Name))
            {
                throw new ArgumentException("没有填写分类名称");
            }
            if (ValueTypes == null || ValueTypes.Length == 0)
            {
                throw new ArgumentException("没有选择数据类型");
            }
        }
    }
}
