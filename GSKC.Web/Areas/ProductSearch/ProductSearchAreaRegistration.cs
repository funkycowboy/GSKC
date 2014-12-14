using System.Web.Mvc;

namespace GSKC.Web.Areas.ProductSearch
{
    public class ProductSearchAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ProductSearch";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "ProductSearch_default",
                "ProductSearch/{controller}/{action}/{id}",
                new { controller = "Home",action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
