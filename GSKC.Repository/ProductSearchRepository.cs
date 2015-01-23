using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GSKC.EF;
using System.Data.Entity;

namespace GSKC.Repository
{
    public class ProductSearchRepository : IProductSearchRepository
    {
        GSKCEntities context = new GSKCEntities(); 

        public IQueryable<ProductCategory> GetProductCategories()
        {
            return context.ProductCategories.OrderBy(x => x.Name).Where(x => x.IsActive);
        }

        public IQueryable<Manufacturer> GetProductManufacturers()
        {
            return context.Manufacturers.OrderBy(x => x.Name).Where(x => x.IsActive);
        }

        public IQueryable<Product> GetProducts()
        {
            return context.Products.OrderBy(x => x.Name).Where(x => x.IsActive);         
        }

        public IQueryable<ProductSection> GetProductSections()
        {
            return context.ProductSections.OrderBy(x => x.Name).Where(x => x.IsActive.Value);         
        }

        public IQueryable<Supplier> GetSuppliers()
        {
            return context.Suppliers.OrderBy(x => x.Name);
        }

        public IQueryable<GetPriceRanges_Result> GetPriceRanges()
        {           
            return context.GetPriceRanges().AsQueryable();                                   
        } 
    }
}
