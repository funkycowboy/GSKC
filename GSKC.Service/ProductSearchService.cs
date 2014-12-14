using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GSKC.Service;
using GSKC.Repository;
using GSKC.BusinessObjects.ProductSearch;
using AutoMapper;

namespace GSKC.Service
{
    public class ProductSearchService : IProductSearchService
    {
        private readonly IProductSearchRepository productSearchRepository;

        public ProductSearchService(IProductSearchRepository productSearchRepository)
        {
            this.productSearchRepository = productSearchRepository;
            Mapper.CreateMap<EF.ProductCategory, ProductCategory>();
            Mapper.CreateMap<EF.Manufacturer, Manufacturer>();

        }

        public List<ProductCategory> GetProductCategories()
        {
            var productCategories = this.productSearchRepository.GetProductCategories();

            return Mapper.Map<List<ProductCategory>>(productCategories);
        }

        public List<Manufacturer> GetProductManufacturers()
        {
            var productManufacturers = this.productSearchRepository.GetProductManufacturers();

            return Mapper.Map<List<Manufacturer>>(productManufacturers);
        }


    }
}
