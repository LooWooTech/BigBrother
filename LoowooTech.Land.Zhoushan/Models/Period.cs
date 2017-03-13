using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public enum Period
    {
        [Description("期内")]
        Default = 0,
        [Description("期末")]
        Sum = 1,
        [Description("期内增加")]
        Added = 2,
        [Description("期内减少")]
        Minus = 3
    }
}
