using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class SeasonManager:ManagerBase
    {
        public int SaveSeason(Season season)
        {

            using (var db = GetDbContext())
            {
                if (season.ID == 0)
                {
                    db.Seasons.Add(season);
                }
                else
                {
                    var entry = db.Seasons.FirstOrDefault(e => e.ID == season.ID);
                    if (entry != null)
                    {
                        db.Entry(entry).CurrentValues.SetValues(season);
                    }
                }
                db.SaveChanges();
                return season.ID;
            }
        }

        public List<Season> GetSeasons()
        {
            using (var db = GetDbContext())
            {
                return db.Seasons.Where(e=>e.Delete==false).ToList();
            }
        }
        public Season GetSeason(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.Seasons.FirstOrDefault(e => e.ID == id);
            }
        }

        public bool CanDelete(int id)
        {
            var season = GetSeason(id);
            if (season == null)
            {
                return false;
            }
            using (var db = GetDbContext())
            {
                var list = db.NodeValues.Where(e => e.Year == season.Year && e.Quarter == season.Quarter).ToList();
                return list.Count == 0;
            }
        }

        public bool Delete(int id)
        {
            if (id == 0) return false;
            using (var db = GetDbContext())
            {
                var entry = db.Seasons.FirstOrDefault(e => e.ID == id);
                if (entry == null || entry.Delete)
                {
                    return false;
                }
                entry.Delete = true;
                db.SaveChanges();
                return true;
            }
        }

        public bool Exist(int year,Quarter quarter)
        {
            using (var db = GetDbContext())
            {
                var entry = db.Seasons.FirstOrDefault(e => e.Year == year && e.Quarter == quarter&&e.Delete==false);
                return entry != null;
            }
        }

        public int[] GetYears()
        {
            using (var db = GetDbContext())
            {
                return db.Seasons.Where(e => e.Delete == false).GroupBy(e=>e.Year).Select(e => e.Key).ToArray();
            }
        }

        public Season GetCurrentSeason()
        {
            using (var db = GetDbContext())
            {
                var season = db.Seasons.Where(e => e.Delete==false && e.StartTime <= DateTime.Now && e.EndTime >= DateTime.Now).FirstOrDefault();
                return season;
            }
        }
        public Season GetNearSeason()
        {
            var list = GetSeasons();
            return list.OrderBy(e => e.TimeSpan).FirstOrDefault();
        }

        public void Statistic(Dictionary<Area,Dictionary<Quarter,List<NodeValue>>> dict)
        {
           
            foreach(var one in dict)
            {
                foreach(var two in one.Value)
                {

                    var item= two.Value.GroupBy(e => e.Node.FormID).ToDictionary(e => e.Key, e => e.ToList());
                    foreach(var three in two.Value)
                    {
                        
                    }
                }
            }
        }

    }
}
