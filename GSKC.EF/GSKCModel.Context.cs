﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GSKC.EF
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class GSKCEntities : DbContext
    {
        public GSKCEntities()
            : base("name=GSKCEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ProductCategory> ProductCategories { get; set; }
        public virtual DbSet<Manufacturer> Manufacturers { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductSection> ProductSections { get; set; }
        public virtual DbSet<Supplier> Suppliers { get; set; }
    
        public virtual ObjectResult<GetPriceRanges_Result> GetPriceRanges()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetPriceRanges_Result>("GetPriceRanges");
        }
    }
}
