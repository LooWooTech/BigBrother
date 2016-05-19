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
        public NodeValue GetNodeValue(int id)
        {
            if (id == 0) return null;

            using (var db = GetDbContext())
            {
                var model = db.NodeValues.FirstOrDefault(e => e.ID == id);
                model.Area = Core.AreaManager.GetArea(model.AreaID);
                model.Type = Core.FormManager.GetNodeValueType(model.TypeID);
                return model;
            }
        }

        public List<NodeValue> GetNodeValues(Node node)
        {
            using (var db = GetDbContext())
            {
                var list = db.NodeValues.Where(e => e.NodeID == node.ID).ToList();
                foreach(var val in list)
                {
                    val.Area = Core.AreaManager.GetArea(val.AreaID);
                    val.Type = Core.FormManager.GetNodeValueType(val.TypeID);
                }
                return node.Values = list;
            }
        }

        public void SaveNodeValue(NodeValue data)
        {
            using (var db = GetDbContext())
            {
                if (data.ID > 0)
                {
                    var entity = db.NodeValues.FirstOrDefault(e => e.ID == data.ID);
                    if (entity != null)
                    {
                        db.Entry(entity).CurrentValues.SetValues(data);
                    }
                }
                else
                {
                    var entity = db.NodeValues.FirstOrDefault(e => e.Year == data.Year
                    && e.TimeID == data.TimeID
                    && e.AreaID == data.AreaID
                    && e.TypeID == data.TypeID
                    && e.NodeID == data.NodeID
                    );
                    if (entity != null)
                    {
                        entity.Value = data.Value;
                    }
                    else
                    {
                        db.NodeValues.Add(data);
                    }
                }
                db.SaveChanges();
            }
        }

        public void DeleteNodeValue(int id)
        {
            using (var db = GetDbContext())
            {
                var entity = db.NodeValues.FirstOrDefault(e => e.ID == id);

                db.NodeValues.Remove(entity);
                db.SaveChanges();
            }
        }

    }
}
