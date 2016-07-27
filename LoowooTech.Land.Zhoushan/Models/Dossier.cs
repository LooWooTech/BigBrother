using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("dossier")]
    public class Dossier
    {
        public Dossier()
        {
            UploadTime = DateTime.Now;
        }
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
        public int Year { get; set; }
        public Quarter Quarter { get; set; }
        public string FilePath { get; set; }
        public DateTime UploadTime { get; set; }
    }
}
