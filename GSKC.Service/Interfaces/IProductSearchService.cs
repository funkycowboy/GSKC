using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GSKC.BusinessObjects.ProductSearch;

namespace GSKC.Service
{
    public interface IProductSearchService
    {
        List<ProductCategory> GetProductCategories();
        List<Manufacturer> GetProductManufacturers();
        List<Product> GetFeaturedProducts();
    }
}
