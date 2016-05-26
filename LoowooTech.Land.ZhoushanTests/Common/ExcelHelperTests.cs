using Microsoft.VisualStudio.TestTools.UnitTesting;
using LoowooTech.Land.Zhoushan.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace LoowooTech.Land.Zhoushan.Common.Tests
{
    [TestClass()]
    public class ExcelHelperTests
    {
        [TestMethod()]
        public void ReadDataTest()
        {
            var filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "test1.xls");
            var list = ExcelHelper.ReadData(filePath);

        }
    }
}