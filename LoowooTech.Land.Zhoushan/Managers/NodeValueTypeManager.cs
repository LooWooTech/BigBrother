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
        public List<NodeValueType> GetNodeValueTypes()
        {
            using (var db = GetDbContext())
            {
                return db.NodeValueTypes.ToList();
            }
        }

        public NodeValueType GetNodeValueType(int id)
        {
            using (var db = GetDbContext())
            {
                return db.NodeValueTypes.FirstOrDefault(e => e.ID == id);
            }
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
