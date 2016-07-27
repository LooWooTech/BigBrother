using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    public class ArchiveController : ControllerBase
    {
        // GET: Archive
        public ActionResult Index()
        {
            var dict = Core.DossierManager.GetDossiers().GroupBy(e => e.Year).ToDictionary(e => e.Key, e => e.OrderBy(k=>k.Quarter).ToList());
            ViewBag.Dict = dict;
            return View();
        }

        public ActionResult Import()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Import(int year,Quarter quarter,string filePath)
        {
            if (Core.DossierManager.Exist(year, quarter))
            {
                return JsonErrorResult(string.Format("当前系统中已经存在{0}年{1}的统计季报,如需要更换，请前往管理界面进行管理！", year, quarter.GetDescription()));
            }
            Core.DossierManager.SaveDossier(new Dossier() { Year = year, Quarter = quarter, FilePath = filePath });
            return JsonSuccessResult();
        }

        public ActionResult Upload()
        {
            if (Request.Files.Count == 0)
            {
                throw new ArgumentException("请选择上传文件");
            }
            var file = Request.Files[0];
            var fileName = file.FileName;
            var filePath = "uploads/" + Path.GetFileNameWithoutExtension(fileName)+DateTime.Now.Ticks.ToString()+Path.GetExtension(fileName);
            var savePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, filePath);
            Request.Files[0].SaveAs(savePath);
            return JsonSuccessResult(new { filePath });
        }

        [HttpGet]
        public ActionResult Search(int? minYear=null,int? maxYear=null,string quarter=null)
        {
            var parameter = new DossierParameter()
            {
                MinYear = minYear,
                MaxYear = maxYear,
                Quarter = quarter
            };
            ViewBag.List = Core.DossierManager.GetDossiers(parameter);
            ViewBag.Parameter = parameter;
            return View();
        }


        


    }
}