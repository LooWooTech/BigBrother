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

        public List<Form> GetForms()
        {
            using (var db = GetDbContext())
            {
                return db.Forms.ToList();
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
