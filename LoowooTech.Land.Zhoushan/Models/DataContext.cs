using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Models
{
    public class DataContext : DbContext
    {
        private static string DbConnectionString = AppSettings.Get("DbConnectionString");

        public DataContext() : this(DbConnectionString) { }

        public DataContext(string nameOrConnectionString) : base(nameOrConnectionString) { }
    }
}
