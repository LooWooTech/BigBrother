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
        private string _typeKey = "nodeValueTypes";

        public List<NodeValueType> GetNodeValueTypes()
        {
            return Cache.GetOrSet(_typeKey, () =>
            {
                using (var db = GetDbContext())
                {
                    return db.NodeValueTypes.ToList();
                }
            });
        }

        private void ClearValueTypeCache()
        {
            Cache.Remove(_typeKey);
        }

        public Node GetNode(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.Nodes.FirstOrDefault(e => e.ID == id);
            }
        }

        public NodeValueType GetNodeValueType(int id)
        {
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
                ClearValueTypeCache();
            }
        }

        public void DeleteNodeValueType(int id)
        {
            using (var db = GetDbContext())
            {
                var entity = db.NodeValueTypes.FirstOrDefault(e => e.ID == id);
                db.NodeValueTypes.Remove(entity);
                db.SaveChanges();
            }
        }
    }
}
