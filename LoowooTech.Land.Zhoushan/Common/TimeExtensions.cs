using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public static class TimeExtensions
    {
        public static int GetQuarter(this DateTime dt)
        {
            return (dt.Month - 1) / 3 + 1;
        }
    }
}
