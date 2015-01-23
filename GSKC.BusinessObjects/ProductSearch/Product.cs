using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GSKC.BusinessObjects.ProductSearch
{
    public class Product
    {
        public int ProductId { get; set; }
        public string SKU { get; set; }
        public string CategoryName { get; set; }
        public int CategoryId { get; set; }
        public string SectionName { get; set; }
        public int SectionId { get; set; }
        public string ProductName { get; set; }
        public string Description { get; set; }
        public string Features { get; set; }
        public string Specifications { get; set; }
        public decimal RetailCost { get; set; }
        public decimal MsrpCost { get; set; }
        public decimal ShippingCost { get; set; }
        public decimal WholCost { get; set; }
        public decimal DealerCost { get; set; }
        public string ManufacturerName { get; set; }
        public int ManufacturerId { get; set; }
        public string ItemNumber { get; set; }
        public int Inventory { get; set; }
        public bool IsActive { get; set; }
        public bool IsFeatured { get; set; }
        public string SupplierName { get; set; }
        public int SupplierId { get; set; }
        public double Weight { get; set; }
        public DateTime DateEntered { get; set; }
        public int EnteredByUserId { get; set; }
        public DateTime DateUpdated { get; set; }
        public int UpdatedByUserId { get; set; }

    }
}
