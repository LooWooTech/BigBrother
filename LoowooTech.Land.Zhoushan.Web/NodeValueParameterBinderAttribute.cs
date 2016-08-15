using LoowooTech.Land.Zhoushan.Models;
using LoowooTech.Land.Zhoushan.Web.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;

namespace LoowooTech.Land.Zhoushan.Web
{
    public class NodeValueParameterBinderAttribute : System.Web.Mvc.CustomModelBinderAttribute
    {
        public override IModelBinder GetBinder()
        {
            return new NodeValueParameterBinder();
        }

        public class NodeValueParameterBinder : IModelBinder
        {
            public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
            {
                var request = controllerContext.HttpContext.Request;
                var result = new NodeValueParameter();

                if (!string.IsNullOrWhiteSpace(request["formId"]))
                {
                    result.FormID = int.Parse(request["formId"]);
                }

                if (!string.IsNullOrWhiteSpace(request["nodeId"]))
                {
                    result.NodeID = int.Parse(request["nodeId"]);
                }

                if (!string.IsNullOrWhiteSpace(request["year"]))
                {
                    result.Year = int.Parse(request["year"]);
                }

                if (!string.IsNullOrWhiteSpace(request["quarter"]))
                {
                    result.Quarter = (Quarter)Enum.Parse(typeof(Quarter), request["quarter"]);
                }

                if (!string.IsNullOrWhiteSpace(request["quarters"]))
                {
                    result.Quarters = request["quarters"].Split(',').Select(str => (Quarter)int.Parse(str)).ToArray();
                    if (result.Quarters.Length < 2)
                    {
                        result.Quarter = result.Quarters[0];
                        result.Quarters = null;
                    }
                }

                if (!string.IsNullOrWhiteSpace(request["rateType"]))
                {
                    result.RateType = (RateType)Enum.Parse(typeof(RateType), request["rateType"]);
                }

                if (!string.IsNullOrWhiteSpace(request["areaId"]))
                {
                    result.AreaID = int.Parse(request["areaId"]);
                }

                //如果是区县用户，则AreaID必须在自己的控制范围内，且自动赋一个默认值
                var identity = (UserIdentity)Thread.CurrentPrincipal.Identity;
                if (identity.Role == UserRole.Branch && result.AreaID == 0)
                {
                    result.AreaID = identity.AreaIds.FirstOrDefault();
                }
                return result;
            }
        }
    }
}