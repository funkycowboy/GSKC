using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GSKC.Web.Areas.ProductSearch.Models
{
    public class SearchCriteriaBaseViewModel
    {
        public int ProductManufacturer { get; set; }
        public int ProductCategory { get; set; }       
        public int ProductPrice { get; set; }
        public string Keyword { get; set; }
    }
}