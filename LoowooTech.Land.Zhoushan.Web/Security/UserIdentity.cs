using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Web.Security
{
    public class UserIdentity : System.Security.Principal.IIdentity
    {
        public static UserIdentity Anonymouse
        {
            get
            {
                return new UserIdentity();
            }
        }

        public int ID { get; set; }

        public string AuthenticationType
        {
            get { return "token"; }
        }

        public UserRole Role { get; set; }

        public bool IsAuthenticated
        {
            get { return ID > 0; }
        }

        public string Name { get; set; }

        private int[] _areaIds;

        public int[] AreaIds
        {
            get
            {
                if (_areaIds == null || _areaIds.Length == 0)
                {
                    return Role > UserRole.Advanced ? null : _areaIds;
                }
                return _areaIds;
            }
            set
            {
                _areaIds = value;
            }
        }

        public int[] ReadAreaIds
        {
            get
            {
                if (Role >= UserRole.Advanced)
                {
                    return null;
                }
                return AreaIds;
            }
        }

        private int[] _formIds;
        public int[] FormIds
        {
            get
            {
                return Role >= UserRole.Maintain ? null : _formIds;
            }
            set { _formIds = value; }
        }
    }
}
