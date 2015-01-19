
import ko = require('knockout');
import mapping = require('knockout.mapping');
import $ = require('jquery');

export function getFeaturedProducts() {

    var productsBaseViewModel = function (data) {
        var self = this;

        var products = data;
        products.forEach(function (item) {
            item.LoggedIn = false;
            item.GroupId = 1;
        });
        self.products = mapping.fromJS(products);    

        self.showAdmin = function (context, productId) {
            alert(productId);
        };   
    }
    $.getJSON("/FeaturedProducts/Home/GetFeaturedProducts", function (data) {
        ko.applyBindings(new productsBaseViewModel(data), document.getElementById("FeaturedProducts"));
    });

}

 
