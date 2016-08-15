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

        public List<Area> GetAreaTree(string[] areaNames=null)
        {
            var list = GetAreas();
            if (areaNames == null)
            {
                list = list.Where(e => e.ParentID == 0).ToList();
                return list;
            }
            else
            {
                var result = new List<Area>();
                foreach (var item in areaNames)
                {
                    var entry=list.FirstOrDefault(e=>e.Name==item);
                    if(entry!=null)
                    {
                        result.Add(entry);
                    }
                }
                return result;
            }
        }

        public Area GetArea(int id)
        {
            if (id == 0) return null;
            return GetAreas().FirstOrDefault(e => e.ID == id);
        }

        public List<Area> GetAreas(int[] areaIDs)
        {
            var list = new List<Area>();
            foreach (var id in areaIDs)
            {
                list.Add(GetArea(id));
            }
            return list;
        }

        public Area GetArea(string name)
        {
            if (string.IsNullOrEmpty(name)) return null;
            return GetAreas().FirstOrDefault(e => e.Name == name);
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
