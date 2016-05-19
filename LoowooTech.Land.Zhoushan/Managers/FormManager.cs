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
        private string _formKey = "forms";
        public Form GetForm(int formId)
        {
            return GetForms().FirstOrDefault(e => e.ID == formId);
        }

        private void ClearFormCache()
        {
            Cache.Remove(_formKey);
        }

        public List<Form> GetForms()
        {
            if (Cache.Exists(_formKey))
            {
                return Cache.HGetAll<Form>(_formKey);
            }

            using (var db = GetDbContext())
            {
                var forms = db.Forms.ToList();
                var nodes = db.Nodes.ToList();
                foreach (var form in forms)
                {
                    var list = nodes.Where(e => e.FormID == form.ID);
                    foreach (var root in list.Where(e => e.ParentID == 0))
                    {
                        root.GetChildren(list);
                        form.Nodes.Add(root);
                    }

                    Cache.HSet(_formKey, form.ID.ToString(), form);
                }

                return forms;
            }
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
                    if(entity != null)
                    {
                        entity.Name = model.Name;
                    }
                }
                db.SaveChanges();
                ClearFormCache();
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
            ClearFormCache();
        }

    }
}
