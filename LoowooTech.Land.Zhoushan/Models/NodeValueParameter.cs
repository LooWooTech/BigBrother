using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public class NodeValueParameter : ICloneable
    {
        public NodeValueParameter()
        {
            AreaID = 0;
            GetArea = true;
            GetValueType = true;
            Quarters = new Quarter[0];
        }

        public int FormID { get; set; }

        public int NodeID { get; set; }

        public int Year { get; set; }

        public Quarter Quarter { get; set; }

        public int? AreaID { get; set; }

        public RateType? RateType { get; set; }

        public int TypeID { get; set; }



        public int[] NodeIds { get; set; }

        public int[] Years { get; set; }

        public Quarter[] Quarters { get; set; }

        public int[] AreaIds { get; set; }

        public int[] TypeIds { get; set; }


        public bool GetNode { get; set; }

        public bool GetArea { get; set; }

        public bool GetValueType { get; set; }


        public void UpdateTimeByRateType()
        {
            switch (RateType)
            {
                case Models.RateType.Chain:
                    var val = (int)Quarter - 1;
                    if (val == 0)
                    {
                        Year = Year - 1;
                        Quarter = Quarter.Fourth;
                    }
                    else
                    {
                        Quarter = (Quarter)val;
                    }
                    break;
                case Models.RateType.YearOnYear:
                    Year = Year - 1;
                    break;
            }
            RateType = null;
        }

        public object Clone()
        {
            return MemberwiseClone();
        }
    }

    public enum RateType
    {
        [Description("同比")]
        YearOnYear,
        [Description("环比")]
        Chain,

    }
}
