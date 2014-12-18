
import ko = require('knockout');
import mapping = require('knockout.mapping');
import $ = require('jquery');

export function getProductInfo() {

    var searchCriteriaBaseViewModel = function (data) {
        var self = this;

        var manufacturers = data.manufacturers;
        manufacturers.forEach(function (item) {
            item.clicked = false;
        });
        self.manufacturers = mapping.fromJS(manufacturers);

        var pricing = data.pricingCategories;
        pricing.forEach(function (item) {
            item.clicked = false;
        });
        self.pricingCategories = mapping.fromJS(pricing);

        var productCategories = data.productCategories;
        productCategories.forEach(function (item) {
            item.clicked = false;
        });
        self.productCategories = mapping.fromJS(productCategories);

        self.clickIt = function (context) {
            if (context.clicked()) {
                context.clicked(false);
            } else {
                context.clicked(true);
            }
        };
    }
    $.getJSON("/ProductSearch/Home/GetProductsInfo", function (data) {
        ko.applyBindings(new searchCriteriaBaseViewModel(data));
    });

}

 
