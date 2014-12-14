var GSKC = {
    GetProductInfo: function () {
        $.getJSON("/ProductSearch/Home/GetProductsInfo", function (data) {
            ko.applyBindings(new GSKC.SearchCriteriaBaseViewModel(data));
        });

    },
    SearchCriteriaBaseViewModel: function (data) {
        var self = this;

        var manufacturers = data.manufacturers;
        manufacturers.forEach(function (item) { item.clicked = false; });
        self.manufacturers = ko.mapping.fromJS(manufacturers);

        var pricing = data.pricingCategories;
        pricing.forEach(function (item) { item.clicked = false; });
        self.pricingCategories = ko.mapping.fromJS(pricing);

        var productCategories = data.productCategories;
        productCategories.forEach(function (item) { item.clicked = false; });
        self.productCategories = ko.mapping.fromJS(productCategories);

        self.clickIt = function (context) {
            debugger;
            if (context.clicked()) {
                context.clicked(false);
            } else {
                context.clicked(true);
            }
        };
    },

};