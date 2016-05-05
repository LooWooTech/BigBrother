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

        private string _config;
        public string Config
        {
            get
            {
                if (Nodes != null)
                {
                    _config = Newtonsoft.Json.JsonConvert.SerializeObject(Nodes);
                }
                return _config;
            }
            set
            {
                _config = value;
                Nodes = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Node>>(_config);
            }
        }

        [NotMapped]
        public List<Node> Nodes { get; private set; }
    }
}
