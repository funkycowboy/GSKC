using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GSKC.BusinessObjects.ProductSearch;
using GSKC.Web.Areas.ProductSearch.Models;
using GSKC.Service;

namespace GSKC.Web.Areas.ProductSearch.Controllers
{
    public class HomeController : Controller
    {
        private readonly IProductSearchService productSearchService;

        public HomeController(IProductSearchService productSearchService)
        {
            this.productSearchService = productSearchService;
        }
        //
        // GET: /ProductSearch/Home/

        public ActionResult Index()
        {
            var model = new SearchCriteriaBaseViewModel();
            return View();
        }

        //
        // GET: /ProductSearch/Home/GetProductsInfo

        public JsonResult GetProductsInfo()
        {
            var data = new
            {
                productCategories = this.productSearchService.GetProductCategories().OrderBy(x => x.Name),
                manufacturers = this.productSearchService.GetProductManufacturers().OrderBy(x => x.Name),
                priceRanges = this.productSearchService.GetPriceRanges()
            };           
            return Json(data, JsonRequestBehavior.AllowGet);
        }

    }
}
