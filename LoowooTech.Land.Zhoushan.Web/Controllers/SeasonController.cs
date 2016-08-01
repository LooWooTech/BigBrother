using LoowooTech.Land.Zhoushan.Common;
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
            if (season.StartTime >= season.EndTime)
            {
                return JsonErrorResult("起始时间不能大于等于截止时间");
            }
            if (season.ID==0&&Core.SeasonManager.Exist(season.Year, season.Quarter))
            {
                return JsonErrorResult(string.Format("当前系统已经存在{0}年度{1}的填报时间,如需修改，请编辑！", season.Year, season.Quarter.GetDescription()));
            }
            Core.SeasonManager.SaveSeason(season);
            return JsonSuccessResult();
        }

        public ActionResult Delete(int id)
        {
            return Core.SeasonManager.Delete(id) ? JsonSuccessResult() : JsonErrorResult("删除失败！当前季度填报记录系统中未找到或者已经删除成功！");
        }

        public ActionResult Statistic()
        {
            ViewBag.Years= Core.SeasonManager.GetYears();
            return View();
        }

        public ActionResult NodeChart(NodeValueParameter parameter)
        {
            parameter.GetArea = true;
            parameter.GetNode = true;
            ViewBag.NodeValues = Core.FormManager.GetNodeValues(parameter);
            return View();
        }
    }
}