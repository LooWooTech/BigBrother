using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public static class MathHelper
    {
        public static double GetRateValue(double value, double compareValue)
        {
            var val = value - compareValue;
            if (compareValue == 0)
            {
                if (val == 0) return 0;
                return val > 0 ? 100 : -100;
            }
            return val / compareValue * 100;
        }
    }
}
