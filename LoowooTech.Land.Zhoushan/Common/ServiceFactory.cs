using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public class Factory<T>
    {
        private static ConcurrentDictionary<string, T> _services = new ConcurrentDictionary<string, T>();


        public static T CreateInstance(string subTypeName)
        {
            if (!_services.ContainsKey(subTypeName))
            {
                var type = Type.GetType(subTypeName, false, true);
                var instance = (T)Activator.CreateInstance(type);
                if (instance != null)
                {
                    _services.TryAdd(subTypeName, instance);
                }
            }
            return _services[subTypeName];
        }
    }
}
