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
        public int NodeID { get; set; }

        public int Year { get; set; }

        public NodeValueTime TimeID { get; set; }

        public int? AreaID { get; set; }

        public RateType? RateType { get; set; }

        public int TypeID { get; set; }

        public bool GetArea { get; set; }

        public bool GetValueType { get; set; }

        public object Clone()
        {
            var obj = (NodeValueParameter)MemberwiseClone();
            switch (obj.RateType)
            {
                case Models.RateType.Chain:
                    var val = (int)TimeID - 1;
                    if (val == 0)
                    {
                        Year = Year - 1;
                        TimeID = NodeValueTime.Session4;
                    }
                    else
                    {
                        TimeID = (NodeValueTime)val;
                    }
                    break;
                case Models.RateType.YearOnYear:
                    Year = Year - 1;
                    break;
            }
            obj.RateType = null;
            return obj;
        }
    }

    public enum RateType
    {
        [Description("环比")]
        Chain,
        [Description("同比")]
        YearOnYear

    }
}
