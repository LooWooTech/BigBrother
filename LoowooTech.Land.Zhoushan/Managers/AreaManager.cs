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
        private static readonly string AreaCacheKey = "areas";

        private void ClearCache()
        {
            Cache.Remove(AreaCacheKey);
        }

        private List<Area> GetAreas()
        {
            return Cache.GetOrSet(AreaCacheKey, () =>
            {
                using (var db = GetDbContext())
                {
                    var list = db.Areas.ToList();
                    foreach (var root in list.Where(e => e.ParentID == 0))
                    {
                        root.GetChildren(list);
                    }
                    return list;
                }
            });
        }

        public List<Area> GetAreaTree(string areaName=null)
        {
            var list = GetAreas();
            if (string.IsNullOrEmpty(areaName))
            {
                list = list.Where(e => e.ParentID == 0).ToList();
            }
            else
            {
                list = list.Where(e => e.Name == areaName).ToList();
            }
            return list;
        }

        public Area GetArea(int id)
        {
            if (id == 0) return null;
            return GetAreas().FirstOrDefault(e => e.ID == id);
        }

        public List<Area> GetAreas(int? parentId = null)
        {
            var list = GetAreas();
            if (parentId.HasValue)
            {
                list = list.Where(e => e.ParentID == parentId.Value).ToList();
            }
            return list;
        }

        public void Save(Area model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.Areas.FirstOrDefault(e => e.ID == model.ID);
                    if (model.ParentID == entity.ID)
                    {
                        model.ParentID = 0;
                    }
                    entity.Name = model.Name;
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
                ClearCache();
            }
        }
    }
}
