using LoowooTech.Land.Zhoushan.Caching;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class AreaManager : ManagerBase
    {

        private string _cacheKey = "areas";
        public List<Area> GetAreas()
        {
            return Cache.GetOrSet(_cacheKey, () =>
            {
                using (var db = GetDbContext())
                {
                    return db.Areas.ToList();
                }
            });
        }

        private void ClearCache()
        {
            Cache.Remove(_cacheKey);
        }

        public Area GetArea(int id)
        {
            return GetAreas().FirstOrDefault(e => e.ID == id);
        }

        public void Save(Area model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.Areas.FirstOrDefault(e => e.ID == model.ID);
                    db.Entry(entity).CurrentValues.SetValues(model);
                }
                else
                {
                    db.Areas.Add(model);
                }
                db.SaveChanges();
                ClearCache();
            }
        }

        public void Delete(int id)
        {
            using (var db = GetDbContext())
            {
                var entity = db.Areas.FirstOrDefault(e => e.ID == id);
                db.Areas.Remove(entity);
                db.SaveChanges();
            }
        }
    }
}
