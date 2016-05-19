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
        public Node GetNode(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.Nodes.FirstOrDefault(e => e.ID == id);
            }
        }

        public void SaveNode(Node model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID == 0)
                {
                    db.Nodes.Add(model);
                }
                else
                {
                    var entity = db.Nodes.FirstOrDefault(e => e.ID == model.ID);
                    db.Entry(entity).CurrentValues.SetValues(model);
                }
                db.SaveChanges();
            }
            ClearFormCache();
        }

        public void DeleteNode(int nodeId)
        {
            using (var db = GetDbContext())
            {
                var hasChild = db.Nodes.Any(e => e.ParentID == nodeId);
                if (hasChild)
                {
                    throw new Exception("该分类包含子分类，无法删除");
                }
                var entity = db.Nodes.FirstOrDefault(e => e.ID == nodeId);
                db.Nodes.Remove(entity);
                db.SaveChanges();
            }
            ClearFormCache();
        }
    }
}
