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
    public class Node
    {
        public Node()
        {
            ID = Guid.NewGuid();
            Children = new List<Node>();
        }

        public Guid ID { get; set; }

        public string Text { get; set; }

        [JsonIgnore]
        public List<NodeValue> Values { get; set; }

        public List<Node> Children { get; set; }

    }
}
