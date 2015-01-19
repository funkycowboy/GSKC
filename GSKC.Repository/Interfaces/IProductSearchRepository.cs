using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GSKC.EF;

namespace GSKC.Repository
{
    public interface IProductSearchRepository
    {
        IQueryable<ProductCategory> GetProductCategories();
        IQueryable<Manufacturer> GetProductManufacturers();
        IQueryable<Product> GetProducts();
        IQueryable<Supplier> GetSuppliers();
        IQueryable<ProductSection> GetProductSections();
    }
}
