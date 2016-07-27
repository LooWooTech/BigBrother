using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    [Table("User")]
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public string Name { get; set; }

        public UserRole Role { get; set; }

        public DateTime? LastLoginTime { get; set; }
        public int? AreaID { get; set; }
        [NotMapped]
        public Area Area { get; set; }

    }

    [Flags]
    public enum UserRole
    {
        [System.ComponentModel.Description("分局用户")]
        Branch =1,
        [System.ComponentModel.Description("市局用户")]
        City = 2,
        [System.ComponentModel.Description("市局高级用户")]
        Advanced = 3,
        [System.ComponentModel.Description("系统管理员")]
        Administrator = 4
    }

}
