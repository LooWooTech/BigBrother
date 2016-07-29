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

        public ActionResult Import(int id=0)
        {
            ViewBag.Dossier = Core.DossierManager.GetDossier(id);
            return View();
        }

        [HttpPost]
        public ActionResult Import(Dossier dossier,string[] filePath,string[] fileName)
        {
            if (dossier.ID==0&&Core.DossierManager.Exist(dossier.Year, dossier.Quarter))
            {
                return JsonErrorResult(string.Format("当前系统中已经存在{0}年{1}的统计季报,如需要更换，请前往管理界面进行管理！", dossier.Year, dossier.Quarter.GetDescription()));
            }
            var id = Core.DossierManager.SaveDossier(dossier);
            Core.DossierManager.SaveDossierFile(id, fileName, filePath);
            return JsonSuccessResult();
        }

        [HttpPost]
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
            return JsonSuccessResult(new { filePath,fileName });
        }

        [HttpGet]
        public ActionResult Search(int? minYear=null,int? maxYear=null,string quarter=null,string remark=null)
        {
            var parameter = new DossierParameter()
            {
                MinYear = minYear,
                MaxYear = maxYear,
                Quarter = quarter,
                Remark=remark
            };
            ViewBag.List = Core.DossierManager.GetDossiers(parameter);
            ViewBag.Parameter = parameter;
            return View();
        }


        


    }
}