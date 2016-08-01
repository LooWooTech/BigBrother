using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class ManagerCore
    {
        protected ManagerCore()
        {
            foreach (var p in this.GetType().GetProperties())
            {
                if (p.PropertyType == this.GetType())
                {
                    continue;
                }
                var val = p.GetValue(this);
                if (val == null)
                {
                    p.SetValue(this, Activator.CreateInstance(p.PropertyType));
                }
            }
        }

        public static readonly ManagerCore Instance = new ManagerCore();

        public UserManager UserManager { get; private set; }

        public FormManager FormManager { get; private set; }

        public AreaManager AreaManager { get; private set; }

        public TemplateManager TemplateManager { get; private set; }
        public DossierManager DossierManager { get; private set; }
        public SeasonManager SeasonManager { get; private set; }
    }
}
