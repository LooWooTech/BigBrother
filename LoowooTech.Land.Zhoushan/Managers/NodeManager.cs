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

        public List<Node> GetNodes(int formId)
        {
            using (var db = GetDbContext())
            {
                var list = db.Nodes.Where(e => e.FormID == formId);
                var result = new List<Node>();
                foreach (var root in list.Where(e => e.ParentID == 0))
                {
                    root.GetChildren(list);
                    result.Add(root);
                }
                return result;
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
        }
    }
}
