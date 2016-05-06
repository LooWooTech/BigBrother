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

    }

    [Flags]
    public enum UserRole
    {
        Guest = 0,
        Reader = 1,
        Writer = 2,
        Administrator = 4
    }

}
