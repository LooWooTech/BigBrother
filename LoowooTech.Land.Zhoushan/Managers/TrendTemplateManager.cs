using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class TrendTemplateManager : ManagerBase
    {
        public List<TrendTemplate> GetList()
        {
            using (var db = GetDbContext())
            {
                return db.TrendTemplates.OrderByDescending(e => e.ID).ToList();
            }
        }

        public TrendTemplate GetModel(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.TrendTemplates.FirstOrDefault(e => e.ID == id);
            }
        }

        public void Save(TrendTemplate model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.TrendTemplates.FirstOrDefault(e => e.ID == model.ID);
                    entity.Name = model.Name;
                    entity.FilePath = model.FilePath;
                }
                else
                {
                    db.TrendTemplates.Add(model);
                }
                db.SaveChanges();
            }
        }

        public void Delete(int id)
        {
            using (var db = GetDbContext())
            {
                var entity =  db.TrendTemplates.FirstOrDefault(e => e.ID == id);
                db.TrendTemplates.Remove(entity);

                db.SaveChanges();
            }
        }
    }
}
