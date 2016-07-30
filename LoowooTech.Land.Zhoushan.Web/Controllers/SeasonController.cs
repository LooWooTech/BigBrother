using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web.Controllers
{
    [UserRoleFilter(Models.UserRole.Administrator)]
    public class SeasonController : ControllerBase
    {
        // GET: Season
        public ActionResult Index()
        {
            ViewBag.List = Core.SeasonManager.GetSeasons();
            return View();
        }

        public ActionResult Edit(int id=0)
        {
            ViewBag.Season = Core.SeasonManager.GetSeason(id);
            return View();
        }

        [HttpPost]
        public ActionResult Edit(Season season)
        {
            Core.SeasonManager.SaveSeason(season);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            return Core.SeasonManager.Delete(id) ? JsonSuccessResult() : JsonErrorResult("删除失败！当前季度填报记录系统中未找到或者已经删除成功！");
        }
    }
}