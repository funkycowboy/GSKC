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
            Mapper.CreateMap<EF.Product, Product>();
            Mapper.CreateMap<EF.GetPriceRanges_Result, ProductPrice>();

        }

        public List<ProductCategory> GetProductCategories()
        {
            return (from pc in this.productSearchRepository.GetProductCategories()
                          join p in this.productSearchRepository.GetProducts() on pc.ProductCategoryID equals p.CategoryID into temp
                            select new ProductCategory()
                              {
                                  Name = pc.Name,
                                  ProductCategoryId = pc.ProductCategoryID,
                                  Count = temp.Count()
                              }).ToList();            
        }

        public List<ProductPrice> GetPriceRanges()
        {
            return this.productSearchRepository.GetPriceRanges().Select(x => new ProductPrice(){
                Name = x.Name,
                PriceRangeId = x.PriceRangeId,
                Count = x.Count.Value
            }).ToList();
        }

        public List<Manufacturer> GetProductManufacturers()
        {
            return (from pm in this.productSearchRepository.GetProductManufacturers()
             join p in this.productSearchRepository.GetProducts() on pm.ManufacturerID equals p.ManufacturerID into temp
             select new Manufacturer()
             {
                 Name = pm.Name,
                 ManufacturerId = pm.ManufacturerID,
                 Count = temp.Count()
             }).ToList();
        }

        public List<Product> GetFeaturedProducts()
        {
            var query = (from p in this.productSearchRepository.GetProducts()
                         join pc in this.productSearchRepository.GetProductCategories() on p.CategoryID equals pc.ProductCategoryID
                         join ps in this.productSearchRepository.GetProductSections() on p.SectionID equals ps.ProductSectionID
                         join su in this.productSearchRepository.GetSuppliers() on p.SupplierID equals su.SupplierID
                         join m in this.productSearchRepository.GetProductManufacturers() on p.ManufacturerID equals m.ManufacturerID
                         where p.IsActive && p.IsFeatured
                         select new Product()
                         {
                             ProductName = p.Name,
                             ProductId = p.ProductID,
                             SKU = p.SKU,
                             CategoryName = pc.Name,
                             CategoryId = p.CategoryID ?? 0,
                             SectionName = ps.Name,
                             SectionId = ps.ProductSectionID,
                             Description = p.Description,
                             Features = p.Features,
                             Specifications = p.Specifications,
                             RetailCost = p.RetailCost ?? 0,
                             MsrpCost = p.MsrpCost ?? 0,
                             ShippingCost = p.ShippingCost ?? 0,
                             WholCost = p.WholCost ?? 0,
                             DealerCost = p.DealerCost ?? 0,
                             ManufacturerName = m.Name,
                             ManufacturerId = p.ManufacturerID ?? 0,
                             ItemNumber = p.ItemNumber,
                             Inventory = p.Inventory ?? 0,
                             IsActive = p.IsActive,
                             IsFeatured = p.IsFeatured,
                             SupplierName = su.Name.Trim(),
                             SupplierId = p.SupplierID ?? 0,
                             Weight = p.Weight ?? 0,
                             DateEntered = p.DateEntered.Value,
                             EnteredByUserId = p.EnteredByUserID ?? 0,
                             DateUpdated = p.DateUpdated.Value,
                             UpdatedByUserId = p.UpdatedByUserID ?? 0
                         }).Take(6);
                
               return query.ToList();
        }


    }
}
