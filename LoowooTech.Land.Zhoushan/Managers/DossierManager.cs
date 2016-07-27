using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class DossierManager:ManagerBase
    {
        public bool Exist(int year,Quarter quarter)
        {
            using (var db = GetDbContext())
            {
                var entry = db.Dossiers.FirstOrDefault(e => e.Year == year && e.Quarter == quarter);
                return entry != null;
            }
        }
        public void SaveDossier(Dossier dossier)
        {
            using (var db = GetDbContext())
            {
                db.Dossiers.Add(dossier);
                db.SaveChanges();
            }
        }

        public List<Dossier> GetDossiers()
        {
            using (var db = GetDbContext())
            {
                return db.Dossiers.ToList();
            }
        }

        public List<Dossier> GetDossiers(DossierParameter parameter)
        {
            using (var db = GetDbContext())
            {
                var query = db.Dossiers.AsQueryable();

                if (parameter.MinYear.HasValue)
                {
                    query = query.Where(e => e.Year >= parameter.MinYear.Value);
                }
                if (parameter.MaxYear.HasValue)
                {
                    query = query.Where(e => e.Year <= parameter.MaxYear.Value);
                }
                if (!string.IsNullOrEmpty(parameter.Quarter))
                {
                    switch (parameter.Quarter)
                    {
                        case "第一季度":
                            query = query.Where(e => e.Quarter == Quarter.First);
                            break;
                        case "第二季度":
                            query = query.Where(e => e.Quarter == Quarter.Second);
                            break;
                        case "第三季度":
                            query = query.Where(e => e.Quarter == Quarter.Third);
                            break;
                        case "第四季度":
                            query = query.Where(e => e.Quarter == Quarter.Fourth);
                            break;
                    }
                }
                return query.ToList();
            }
        }
    }
}
