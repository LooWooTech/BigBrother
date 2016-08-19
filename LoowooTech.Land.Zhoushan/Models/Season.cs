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
    [Table("season")]
    public class Season
    {
        public Season()
        {
            SetTime = DateTime.Now;
        }
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }
        public int Year { get; set; }
        public Quarter Quarter { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public DateTime SetTime { get; set; }
        public bool Delete { get; set; }

        [NotMapped]
        public bool Indate
        {
            get
            {
                return DateTime.Now >= StartTime && DateTime.Now <= EndTime && !Delete;
            }
        }
        [NotMapped]
        public TimeSpan TimeSpan
        {
            get
            {
                return DateTime.Now - EndTime;
            }
        }
    }
}
