using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Caching
{
    public class NoneCacheService : ICacheService
    {
        public void Set(string key, object value, TimeSpan? expiry = null)
        {
        }

        public T Get<T>(string key)
        {
            return default(T);
        }

        public void HSet(string hashId, string key, object value)
        {
        }

        public T HGet<T>(string hashId, string key)
        {
            return default(T);
        }

        public void Remove(string key)
        {
        }

        public void Clear()
        {
        }


        public bool Exists(string key)
        {
            return false;
        }

        public void HRemove(string hashId, string key)
        {
        }


        public List<T> HGetAll<T>(string hashId)
        {
            return new List<T>();
        }


        public void HSetAll<T>(string hashId, Dictionary<string, T> dict)
        {
        }
    }
}
