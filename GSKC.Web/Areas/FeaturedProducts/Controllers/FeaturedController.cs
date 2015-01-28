using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GSKC.Service;
using AutoMapper;
using GSKC.Web.Areas.FeaturedProducts.Models;
using GSKC.BusinessObjects.ProductSearch;

namespace GSKC.Web.Areas.FeaturedProducts.Controllers
{
    public class HomeController : Controller
    {
        private readonly IProductSearchService productSearchService;

         public HomeController(IProductSearchService productSearchService)
        {
            this.productSearchService = productSearchService;
            this.CreateMappings();
        }

        private void CreateMappings()
        {
            Mapper.CreateMap<Product, FeaturedProductsBaseViewModel>()
                .ForMember(x => x.MsrpCost, opt => opt.MapFrom(src => src.MsrpCost));
        }

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Home/GetFeaturedProducts

        public JsonResult GetFeaturedProducts()
        {
            var model = this.productSearchService.GetFeaturedProducts();
            var data = Mapper.Map<List<FeaturedProductsBaseViewModel>>(model);

            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}
