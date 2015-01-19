using System.Web.Mvc;

namespace GSKC.Web.Areas.FeaturedProducts
{
    public class FeaturedProductsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "FeaturedProducts";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "FeaturedProducts_default",
                "FeaturedProducts/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
