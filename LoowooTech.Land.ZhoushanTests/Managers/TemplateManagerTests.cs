using Microsoft.VisualStudio.TestTools.UnitTesting;
using LoowooTech.Land.Zhoushan.Managers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers.Tests
{
    [TestClass()]
    public class TemplateManagerTests
    {
        [TestMethod()]
        public void GetTemplateTest()
        {
            var manager = new TemplateManager();
            var template = manager.GetTemplate(1);
        }
    }
}