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

        public List<NodeValue> GetChildNodeValues(NodeValueParameter parameter)
        {
            using (var db = GetDbContext())
            {
                var nodes = Core.FormManager.GetNodeChildren(parameter.NodeID);
                var childIds = nodes.Select(e => e.ID).ToArray();
                var p = (NodeValueParameter)parameter.Clone();
                p.NodeID = 0;
                p.NodeIds = childIds;
                p.GetNode = false;
                var list = Core.FormManager.GetNodeValues(p);
                foreach (var item in list)
                {
                    item.Node = nodes.FirstOrDefault(e => e.ID == item.NodeID);
                }
                return list;
            }
        }

        public List<NodeValue> GetNodeValues(NodeValueParameter parameter)
        {
            using (var db = GetDbContext())
            {
                var query = db.NodeValues.AsQueryable();

                if (parameter.NodeIds != null)
                {
                    query = query.Where(e => parameter.NodeIds.Contains(e.NodeID));
                }
                else if (parameter.NodeID > 0)
                {
                    query = query.Where(e => e.NodeID == parameter.NodeID);
                }
                else
                {
                    throw new ArgumentException("参数不正确");
                }

                if (parameter.Years != null)
                {
                    query = query.Where(e => parameter.Years.Contains(e.Year));
                }
                else if (parameter.Year > 0)
                {
                    query = query.Where(e => e.Year == parameter.Year);
                }

                if (parameter.TypeIds != null)
                {
                    query = query.Where(e => parameter.TypeIds.Contains(e.TypeID));
                }
                else if (parameter.TypeID > 0)
                {
                    query = query.Where(e => e.TypeID == parameter.TypeID);
                }

                if (parameter.Quarters != null)
                {
                    query = query.Where(e => parameter.Quarters.Contains(e.Quarter));
                }
                else if (parameter.Quarter > 0)
                {
                    query = query.Where(e => e.Quarter == parameter.Quarter);
                }

                if (parameter.AreaIds != null)
                {
                    query = query.Where(e => parameter.AreaIds.Contains(e.AreaID));
                }
                else if (parameter.AreaID.HasValue)
                {
                    query = query.Where(e => e.AreaID == parameter.AreaID.Value);
                }

                var list = query.ToList();
                List<Area> areas = parameter.GetArea ? Core.AreaManager.GetAreas() : null;
                List<NodeValueType> types = parameter.GetValueType ? Core.FormManager.GetNodeValueTypes() : null;
                foreach (var item in list)
                {
                    if (parameter.GetArea)
                    {
                        item.Area = areas.FirstOrDefault(e => e.ID == item.AreaID);
                    }
                    if (parameter.GetValueType)
                    {
                        item.Type = types.FirstOrDefault(e => e.ID == item.TypeID);
                    }
                }

                if (parameter.RateType.HasValue)
                {
                    var compareParameter = (NodeValueParameter)parameter.Clone();
                    compareParameter.UpdateTimeByRateType();
                    var compareList = GetNodeValues(compareParameter);
                    foreach (var item in list)
                    {
                        var compareItem = compareList.FirstOrDefault(e =>
                            e.NodeID == item.NodeID
                            && e.Year == item.Year
                            && e.Quarter == item.Quarter
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
                    && e.Quarter == data.Quarter
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
