using LoowooTech.Land.Zhoushan.Caching;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public partial class FormManager
    {
        private static readonly string ValueCacheKey = "valueTypes";
        private void ClearValueCache()
        {
            Cache.Remove(ValueCacheKey);
        }

        public List<NodeValueType> GetNodeValueTypes()
        {
            return Cache.GetOrSet(ValueCacheKey, () =>
            {
                using (var db = GetDbContext())
                {
                    return db.NodeValueTypes.ToList();
                }
            });
        }

        public List<NodeValueType> GetNodeValueTypes(int nodeId)
        {
            using (var db = GetDbContext())
            {
                var typeIds = db.NodeValues.Where(e => e.NodeID == nodeId).Select(e => e.TypeID).ToArray();
                return GetNodeValueTypes().Where(e => typeIds.Contains(e.ID)).ToList();
            }
        }

        public NodeValueType GetNodeValueType(int id)
        {
            if (id == 0) return null;
            return GetNodeValueTypes().FirstOrDefault(e => e.ID == id);
        }

        public void SaveNodeValueType(NodeValueType model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.NodeValueTypes.FirstOrDefault(e => e.ID == model.ID);
                    db.Entry(entity).CurrentValues.SetValues(model);
                }
                else
                {
                    db.NodeValueTypes.Add(model);
                }
                db.SaveChanges();
                ClearValueCache();
            }
        }

        public void DeleteNodeValueType(int id)
        {
            using (var db = GetDbContext())
            {
                var entity = db.NodeValueTypes.FirstOrDefault(e => e.ID == id);
                db.NodeValueTypes.Remove(entity);
                db.SaveChanges();
                ClearValueCache();
            }
        }
    }
}
