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

        public List<Area> GetAreas()
        {
            using (var db = GetDbContext())
            {
                var result = new List<Area>();
                var list = db.Areas.ToList();
                foreach (var root in list.Where(e => e.ParentID == 0))
                {
                    root.GetChildren(list);
                    result.Add(root);
                }

                return result;
            }
        }

        public Area GetArea(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.Areas.FirstOrDefault(e => e.ID == id);
            }
        }

        public void Save(Area model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.Areas.FirstOrDefault(e => e.ID == model.ID);
                    if(model.ParentID == entity.ID)
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
