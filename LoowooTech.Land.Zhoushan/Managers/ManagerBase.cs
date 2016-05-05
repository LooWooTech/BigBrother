using LoowooTech.Land.Zhoushan.Caching;
using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public abstract class ManagerBase
    {
        public ManagerBase()
        {
            Cache = Factory<ICacheService>.CreateInstance(AppSettings.Get("Cache") ?? "LoowooTech.Land.Zhoushan.Caching.LocalCacheService");
        }

        protected ICacheService Cache;

        public virtual DataContext GetDbContext()
        {
            return new DataContext();
        }
    }
}
