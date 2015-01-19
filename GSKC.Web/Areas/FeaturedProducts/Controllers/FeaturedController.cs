using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GSKC.Service;

namespace GSKC.Web.Areas.FeaturedProducts.Controllers
{
    public class HomeController : Controller
    {

         private readonly IProductSearchService productSearchService;

         public HomeController(IProductSearchService productSearchService)
        {
            this.productSearchService = productSearchService;
        }

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Home/GetFeaturedProducts

        public JsonResult GetFeaturedProducts()
        {
            var data = this.productSearchService.GetFeaturedProducts();

            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}
