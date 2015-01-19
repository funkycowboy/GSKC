define(["require", "exports", 'knockout', 'knockout.mapping', 'jquery'], function(require, exports, ko, mapping, $) {
    function getFeaturedProducts() {
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
        };
        $.getJSON("/FeaturedProducts/Home/GetFeaturedProducts", function (data) {
            ko.applyBindings(new productsBaseViewModel(data), document.getElementById("FeaturedProducts"));
        });
    }
    exports.getFeaturedProducts = getFeaturedProducts;
});
//# sourceMappingURL=FeaturedProducts.js.map
