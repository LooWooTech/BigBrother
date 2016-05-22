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

        public List<NodeValue> GetNodeValues(NodeValueParameter parameter)
        {
            using (var db = GetDbContext())
            {
                var query = db.NodeValues.Where(e =>
                e.NodeID == parameter.NodeID
                && e.Year == parameter.Year
                && e.TimeID == parameter.TimeID
                && e.TypeID == parameter.TypeID
                );
                if (parameter.AreaID.HasValue)
                {
                    query = query.Where(e => e.AreaID == parameter.AreaID);
                }

                var list = query.ToList();
                foreach (var item in list)
                {
                    if (parameter.GetArea)
                    {
                        item.Area = Core.AreaManager.GetArea(item.AreaID);
                    }
                    if (parameter.GetValueType)
                    {
                        item.Type = Core.FormManager.GetNodeValueType(item.TypeID);
                    }
                }

                if (parameter.RateType.HasValue)
                {
                    var compareParameter = (NodeValueParameter)parameter.Clone();
                    var compareList = GetNodeValues(compareParameter);
                    foreach (var item in list)
                    {
                        var compareItem = compareList.FirstOrDefault(e =>
                            e.NodeID == item.NodeID
                            && e.Year == item.Year
                            && e.TimeID == item.TimeID
                            && e.TypeID == item.TypeID
                            && e.AreaID == item.AreaID
                        );
                        if (compareItem != null)
                        {
                            item.CompareValue = compareItem.Value;
                        }
                    }
                }
                return list;
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
