using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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

        public int[] GetNodeIds(int formId)
        {
            using (var db = GetDbContext())
            {
                return db.Nodes.Where(e => e.FormID == formId).Select(e => e.ID).ToArray();
            }
        }

        public int[] GetFormYears(int formId)
        {
            using (var db = GetDbContext())
            {
                var nodeIds = GetNodeIds(formId);
                return db.NodeValues.Where(e => nodeIds.Contains(e.NodeID)).GroupBy(e => e.Year).Select(g => g.Key).ToArray();
            }
        }

        public List<Node> GetAllChildrenNodes(int formId, int nodeId)
        {
            if (formId == 0 && nodeId == 0)
            {
                throw new Exception("参数错误");
            }
            if (nodeId > 0)
            {
                var nodes = GetNodeChildren(nodeId);
                var result = new List<Node>();
                foreach (var node in nodes)
                {
                    TileNodeAndChildren(result, node);
                }

                return result;
            }
            else
            {
                return GetNodes().Where(e => e.FormID == formId).ToList();
            }
        }

        private void TileNodeAndChildren(List<Node> result, Node node)
        {
            result.Add(node);
            foreach (var child in node.Children)
            {
                TileNodeAndChildren(result, child);
            }
        }

        //public List<NodeValue> GetChildNodeValues(NodeValueParameter parameter)
        //{
        //    using (var db = GetDbContext())
        //    {
        //        var nodes = Core.FormManager.GetNodeChildren(parameter.NodeID);
        //        var childIds = nodes.Select(e => e.ID).ToArray();
        //        var p = (NodeValueParameter)parameter.Clone();
        //        p.NodeID = 0;
        //        p.NodeIds = childIds;
        //        p.GetNode = false;
        //        var list = Core.FormManager.GetNodeValues(p);
        //        foreach (var item in list)
        //        {
        //            item.Node = nodes.FirstOrDefault(e => e.ID == item.NodeID);
        //        }
        //        return list;
        //    }
        //}

        public void DeleteNodeValues(int formId, int year, Quarter quarter)
        {
            using (var db = GetDbContext())
            {
                var nodeIds = GetNodeIds(formId);
                var query = db.NodeValues.Where(e => nodeIds.Contains(e.NodeID) && e.Year == year && e.Quarter == quarter);
                db.NodeValues.RemoveRange(query);
                db.SaveChanges();
            }
        }

        public List<NodeValue> GetNodeValues(NodeValueParameter parameter)
        {
            using (var db = GetDbContext())
            {
                if (parameter.FormID > 0 && parameter.NodeID == 0 && (parameter.NodeIds == null || parameter.NodeIds.Length == 0))
                {
                    parameter.NodeIds = GetNodeIds(parameter.FormID);
                }

                var query = db.NodeValues.AsQueryable();

                if (parameter.NodeIds != null && parameter.NodeIds.Length > 0)
                {
                    query = query.Where(e => parameter.NodeIds.Contains(e.NodeID));
                }
                else if (parameter.NodeID > 0)
                {
                    query = query.Where(e => e.NodeID == parameter.NodeID);
                }

                if (parameter.Years != null && parameter.Years.Length > 0)
                {
                    query = query.Where(e => parameter.Years.Contains(e.Year));
                }
                else if (parameter.Year > 0)
                {
                    query = query.Where(e => e.Year == parameter.Year);
                }

                if (parameter.TypeIds != null && parameter.TypeIds.Length > 0)
                {
                    query = query.Where(e => parameter.TypeIds.Contains(e.TypeID));
                }
                else if (parameter.TypeID > 0)
                {
                    query = query.Where(e => e.TypeID == parameter.TypeID);
                }

                if (parameter.Quarters != null && parameter.Quarters.Length > 0)
                {
                    query = query.Where(e => parameter.Quarters.Contains(e.Quarter));
                }
                else if (parameter.Quarter > 0)
                {
                    query = query.Where(e => e.Quarter == parameter.Quarter);
                }

                if (parameter.AreaIds != null && parameter.AreaIds.Length > 0)
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
                    if (parameter.GetNode)
                    {
                        item.Node = Core.FormManager.GetNode(item.NodeID);
                    }
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
                            && e.TypeID == item.TypeID
                            && e.AreaID == item.AreaID
                        );
                        if (compareItem != null)
                        {
                            item.CompareValue = compareItem.RawValue;
                        }
                    }
                }
                return list;
            }
        }

        public void SaveNodeValue(NodeValue data, bool importValue)
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
                        if (importValue)
                        {
                            entity.RawValue = data.RawValue;
                        }
                        else
                        {
                            entity.RawValue = data.Value;
                            entity.Value = data.Value;
                        }
                    }
                    else
                    {
                        if (importValue)
                        {
                            data.Value = data.RawValue;
                        }
                        else
                        {
                            data.RawValue = data.Value;
                        }
                        db.NodeValues.Add(data);
                    }
                }
                db.SaveChanges();
            }
        }

        public void SaveNodeValues(List<NodeValue> values)
        {
            foreach (var val in values)
            {
                SaveNodeValue(val, false);
            }
        }

        /// <summary>
        /// 计算表单分类的各种合计
        /// </summary>
        public void ComputeSumValue(int formId, int year, Quarter quarter, List<NodeValue> submitValues)
        {
            new Thread(() =>
            {
                var form = Core.FormManager.GetForm(formId);
                foreach (var val in submitValues)
                {
                    UpdateParentAreaValue(val, form);
                }
                _updateList.Clear();
            }).Start();
        }

        private List<NodeValueParameter> _updateList = new List<NodeValueParameter>();
        private void UpdateParentAreaValue(NodeValue val, Form form)
        {
            if (val.AreaID == 0) return;

            var area = Core.AreaManager.GetArea(val.AreaID);
            if (area == null) return;

            //如果form设置了不自动计算子区域，那么非舟山市本身的总计外，其他父区域不自动计算
            if (form.ExcludeSubArea && area.ParentID != 0)
            {
                return;
            }

            var parameter = new NodeValueParameter(val) { AreaID = area.ParentID };
            //判断是否已经更新了同条件的parentarea的value
            if (_updateList.Any(e => e.EqualSingleValueParameter(parameter)))
            {
                return;
            }
            //查询子分类的ID
            parameter.AreaIds = Core.AreaManager.GetChildAreaIds(area.ParentID);

            //这里只应该有一条记录
            var parentValue = GetOrSetParentAreaValueEntity(parameter);
            _updateList.Add(parameter);
            //更新新值的父区域数据
            UpdateParentAreaValue(parentValue, form);
        }

        private NodeValue GetOrSetParentAreaValueEntity(NodeValueParameter parameter)
        {
            using (var db = GetDbContext())
            {
                var entity = db.NodeValues.FirstOrDefault(e => e.AreaID == parameter.AreaID.Value
                 && e.Year == parameter.Year
                   && e.Quarter == parameter.Quarter
                   && e.TypeID == parameter.TypeID
                   && e.NodeID == parameter.NodeID
                );
                if (entity == null)
                {
                    entity = new NodeValue(parameter);
                    db.NodeValues.Add(entity);
                }
                entity.RawValue = db.NodeValues.Where(e => parameter.AreaIds.Contains(e.AreaID)
                 && e.Year == parameter.Year
                   && e.Quarter == parameter.Quarter
                   && e.TypeID == parameter.TypeID
                   && e.NodeID == parameter.NodeID
                ).Select(e => e.RawValue).DefaultIfEmpty(0).Sum();
                db.SaveChanges();

                return entity;
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
