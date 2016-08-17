using LoowooTech.Land.Zhoushan.Caching;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public partial class FormManager : ManagerBase
    {
        public Form GetForm(int formId)
        {
            using (var db = GetDbContext())
            {
                return db.Forms.FirstOrDefault(e => e.ID == formId);
            }
        }

        public List<Form> GetForms(int[] formIds=null)
        {
            if (formIds == null||formIds.Count()==0)
            {
                using (var db = GetDbContext())
                {
                    return db.Forms.ToList();
                }
            }
            var list = new List<Form>();
            foreach(var id in formIds)
            {
                var entry = GetForm(id);
                if (entry != null)
                {
                    list.Add(entry);
                }
            }
            return list;

        }

        public void SaveForm(Form model)
        {
            using (var db = GetDbContext())
            {
                if (model.ID == 0)
                {
                    db.Forms.Add(model);
                }
                else
                {
                    var entity = db.Forms.FirstOrDefault(e => e.ID == model.ID);
                    db.Entry(entity).CurrentValues.SetValues(model);
                }
                db.SaveChanges();
            }
        }

        public void DeleteForm(int formId)
        {
            using (var db = GetDbContext())
            {
                var nodes = db.Nodes.Where(e => e.FormID == formId);
                db.Nodes.RemoveRange(nodes);

                var form = db.Forms.FirstOrDefault(e => e.ID == formId);
                db.Forms.Remove(form);

                db.SaveChanges();
            }
        }

    }
}
