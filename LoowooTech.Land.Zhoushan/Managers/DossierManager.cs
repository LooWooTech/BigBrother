using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class DossierManager : ManagerBase
    {
        public bool Exist(int year, Quarter quarter)
        {
            using (var db = GetDbContext())
            {
                var entry = db.Dossiers.FirstOrDefault(e => e.Year == year && e.Quarter == quarter);
                return entry != null;
            }
        }
        public int SaveDossier(Dossier dossier)
        {
            using (var db = GetDbContext())
            {
                if (dossier.ID == 0)
                {
                    db.Dossiers.Add(dossier);

                }
                else
                {
                    var entry = db.Dossiers.FirstOrDefault(e => e.ID == dossier.ID);
                    entry.Year = dossier.Year;
                    entry.Quarter = dossier.Quarter;
                    entry.UploadTime = dossier.UploadTime;
                    entry.Remark = dossier.Remark;
                }
                db.SaveChanges();
                return dossier.ID;
            }
        }

        public List<Dossier> GetDossiers()
        {
            using (var db = GetDbContext())
            {
                var list = db.Dossiers.ToList();
                foreach (var item in list)
                {
                    item.Files = db.DossierFiles.Where(e => e.DossierID == item.ID).ToList();
                }
                return list;
            }
        }

        public void SaveDossierFile(int id, string[] fileName, string[] filePath)
        {
            if (id == 0) return;
            var list = new List<DossierFile>();
            var count = fileName.Count();
            for (var i = 0; i < count; i++)
            {
                list.Add(new DossierFile() { FileName = fileName[i], FilePath = filePath[i], DossierID = id });
            }
            using (var db = GetDbContext())
            {
                var old = db.DossierFiles.Where(e => e.DossierID == id).ToList();
                if (old != null)
                {
                    db.DossierFiles.RemoveRange(old);
                    db.SaveChanges();
                }
                db.DossierFiles.AddRange(list);
                db.SaveChanges();
            }
        }

        public Dossier GetDossier(int id)
        {
            if (id == 0)
            {
                return null;
            }
            using (var db = GetDbContext())
            {
                var dossier = db.Dossiers.FirstOrDefault(e => e.ID == id);
                if (dossier != null)
                {
                    dossier.Files = db.DossierFiles.Where(e => e.DossierID == dossier.ID).ToList();
                }
                return dossier;
            }
        }

        public void Delete(int id)
        {
            using (var db = GetDbContext())
            {
                var dossier = db.Dossiers.FirstOrDefault(e => e.ID == id);
                if (dossier != null)
                {
                    db.Dossiers.Remove(dossier);
                    db.SaveChanges();
                }
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
                if (!string.IsNullOrEmpty(parameter.Remark))
                {
                    query = query.Where(e => e.Remark.Contains(parameter.Remark));
                }
                if (!string.IsNullOrEmpty(parameter.Quarter))
                {
                    switch (parameter.Quarter)
                    {
                        case "上半年":
                            query = query.Where(e => e.Quarter == Quarter.HaflYear);
                            break;
                        case "全年度":
                            query = query.Where(e => e.Quarter == Quarter.FullYear);
                            break;
                            //case "第一季度":
                            //    query = query.Where(e => e.Quarter == Quarter.First);
                            //    break;
                            //case "第二季度":
                            //    query = query.Where(e => e.Quarter == Quarter.Second);
                            //    break;
                            //case "第三季度":
                            //    query = query.Where(e => e.Quarter == Quarter.Third);
                            //    break;
                            //case "第四季度":
                            //    query = query.Where(e => e.Quarter == Quarter.Fourth);
                            //    break;
                    }
                }
                var list = query.ToList();
                foreach (var item in list)
                {
                    item.Files = db.DossierFiles.Where(e => e.DossierID == item.ID).ToList();
                }
                return list;
            }
        }
    }
}
