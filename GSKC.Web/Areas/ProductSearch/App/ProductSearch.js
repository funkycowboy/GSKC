define(["require", "exports", 'knockout', 'knockout.mapping', 'jquery'], function(require, exports, ko, mapping, $) {
    var context = "#ProductSearch";

    function getProductInfo() {
        var searchCriteriaBaseViewModel = function (data) {
            var self = this;

            var stringStartsWith = function (string, startsWith) {
                string = string || "";
                if (startsWith.length > string.length)
                    return false;
                return string.substring(0, startsWith.length) === startsWith;
            };

            var filterArray = function (data, filter) {
                var filter = filter.toLowerCase();

                if (filter === "") {
                    return data;
                } else {
                    return ko.utils.arrayFilter(data, function (item) {
                        return stringStartsWith(item.Name().toLowerCase(), filter);
                    });
                }
            };

            var manufacturers = data.manufacturers;
            manufacturers.forEach(function (item) {
                item.clicked = false;
            });

            self.filterTextManufacturers = ko.observable('');
            self.manufacturers = mapping.fromJS(manufacturers);
            self.selectedManufacturers = ko.observableArray();
            self.filteredManufacturers = ko.computed(function () {
                return filterArray(self.manufacturers(), self.filterTextManufacturers());
            }, self);

            var pricing = data.priceRanges;
            pricing.forEach(function (item) {
                item.clicked = false;
            });
            self.priceRanges = mapping.fromJS(pricing);
            self.selectedPriceRanges = ko.observableArray();

            var categories = data.productCategories;
            categories.forEach(function (item) {
                item.clicked = false;
            });
            self.filterTextCategories = ko.observable('');
            self.categories = mapping.fromJS(categories);
            self.selectedCategories = ko.observableArray();
            self.filteredCategories = ko.computed(function () {
                return filterArray(self.categories(), self.filterTextCategories());
            }, self);

            var targetArrayRemove;
            var targetArrayAdd;
            var countManufacturer = 1;
            var countPrice = 1;
            var countProduct = 1;
            self.showSelectedManufacturer = ko.observable(false);
            self.showSelectedPrice = ko.observable(false);
            self.showSelectedProduct = ko.observable(false);

            self.addSelected = function (param, data, event) {
                switch (param) {
                    case "manufacturer":
                        if (countManufacturer > 5)
                            return;
                        targetArrayRemove = self.manufacturers;
                        targetArrayAdd = self.selectedManufacturers;
                        countManufacturer++;
                        self.showSelectedManufacturer(true);
                        break;
                    case "price":
                        if (countPrice > 5)
                            return;
                        targetArrayRemove = self.priceRanges;
                        targetArrayAdd = self.selectedPriceRanges;
                        countPrice++;
                        self.showSelectedPrice(true);
                        break;
                    case "product":
                        if (countProduct > 5)
                            return;
                        targetArrayRemove = self.categories;
                        targetArrayAdd = self.selectedCategories;
                        countProduct++;
                        self.showSelectedProduct(true);
                        break;
                }

                targetArrayRemove.remove(data);
                data.clicked(true);
                targetArrayAdd.push(data);
                self.initializeControls();
            };
            self.removeSelected = function (param, data, event) {
                switch (param) {
                    case "manufacturer":
                        targetArrayRemove = self.selectedManufacturers;
                        targetArrayAdd = self.manufacturers;
                        countManufacturer--;
                        if (countManufacturer == 1)
                            self.showSelectedManufacturer(false);
                        break;
                    case "price":
                        targetArrayRemove = self.selectedPriceRanges;
                        targetArrayAdd = self.priceRanges;
                        countPrice--;
                        if (countPrice == 1)
                            self.showSelectedPrice(false);
                        break;
                    case "product":
                        targetArrayRemove = self.selectedCategories;
                        targetArrayAdd = self.categories;
                        countProduct--;
                        if (countProduct == 1)
                            self.showSelectedProduct(false);
                        break;
                }
                targetArrayRemove.remove(data);
                data.clicked(false);
                targetArrayAdd.push(data);
                targetArrayAdd.sort(function (left, right) {
                    return left.Name() == right.Name() ? 0 : (left.Name() < right.Name() ? -1 : 1);
                });
            };
            self.animate = function (element, index, data) {
                $(element).filter("li").fadeIn(500);
            };

            self.tidyList = function (element) {
                var $list = $(element).closest(".filter-list");
                var $filteredListContainer = $list;
                var $listContainer = $filteredListContainer;
                var listContainerHeight = $listContainer.height();
                var listHeight = $listContainer.find("ul").height();
                if (listHeight > 0 && listHeight < 200) {
                    $listContainer.animate({ height: listHeight + 40 });
                } else {
                    $listContainer.animate({ height: 210 });
                }
            };
            self.slideFilterList = function () {
                var $target = $(event.target);
                $target.parent().find(".button-arrow").toggleClass("open");
                $target.closest(".filter-header").find(".filter-list-parent").slideToggle('slow', function () {
                });
            };

            self.initializeControls = function () {
                if ($(window).width() <= 767) {
                    $("footer").show();
                } else {
                    $("footer").hide();
                }
                $("footer").addClass("visible-xs");
            };
        };
        $.getJSON("/ProductSearch/Home/GetProductsInfo", function (data) {
            ko.applyBindings(new searchCriteriaBaseViewModel(data), document.getElementById("ProductSearch"));
        });
    }

    function bindEvents() {
        $(context).on("blur", "input[type=text]", function () {
            if ($(this).val() != "") {
                loadContent("SearchForm");
            }
        });

        $(context).on("keypress", "#Keyword", function (e) {
            var form = $(this).closest("form");
            if (e.which == 13) {
                form.submit();
                return false;
            }
        });
        //History.js
        //var History = window.History;
        //if (History.enabled) {
        //    State = History.getState();
        //    // set initial state to first page that was loaded
        //    History.pushState(null, null, State.url);
        //} else {
        //    return false;
        //}
        // Content update and back/forward button handler
        //History.Adapter.bind(window, 'statechange', function () {
        //    var State = History.getState();
        //    $.ajax({
        //        type: "POST",
        //        url: "/Content/SearchResults/SearchResults.asp",
        //        data: State.data.formData,
        //        success: function (data) {
        //            setTimeout(function () {
        //                $("#async-content").html(data);
        //                $("#SearchResultsData").show();
        //                $("#SearchForm").html(State.data.searchOptions);
        //            }, 500);
        //            //$(".loading").remove();
        //        },
        //        beforeSend: function () {
        //            $("#SearchResultsData").hide();
        //            $(".loading").show();
        //        }
        //    });
        //});
    }

    function loadContent(theForm) {
        //var theForm = "#" + theForm;
        ////alert(theForm);
        //var data = $(theForm).serialize();
        //var loadingContainer = $("<div/>").addClass("loading");
        //var loadingBg = $("<div/>");
        //var loadingImage = $("<img/>").attr("src", "/Images/InterfaceElements/ajax-loader.gif").attr("id", "Loading");
        //loadingBg.append(loadingImage);
        //loadingContainer.append(loadingBg);
        //$("#async-content").append(loadingContainer);
        //data = "?PageID=3&" + data
        ////data = gskc.Utilities.removeURLParam("?" + data, "LoggedIn");
        ////data = gskc.Utilities.removeURLParam(data, "GroupID");
        //History.pushState({ formData: data, searchOptions: $("#SearchForm").formhtml() }, "Search Results", data);
    }

    function initialize() {
        (function ($) {
            jQuery.expr[':'].Contains = function (a, i, m) {
                return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
            };
        }(jQuery));

        (function ($) {
            //return form html with updated DOM, not just the default html()
            var oldHTML = $.fn.html;

            $.fn.formhtml = function () {
                if (arguments.length)
                    return oldHTML.apply(this, arguments);
                $("input,button", this).each(function () {
                    this.setAttribute('value', this.value);
                });
                $("textarea", this).each(function () {
                    // updated - thanks Raja & Dr. Fred!
                    $(this).text(this.value);
                });
                $("input:radio,input:checkbox", this).each(function () {
                    // im not really even sure you need to do this for "checked"
                    // but what the heck, better safe than sorry
                    if (this.checked)
                        this.setAttribute('checked', 'checked');
                    else
                        this.removeAttribute('checked');
                });
                $("option", this).each(function () {
                    // also not sure, but, better safe...
                    if (this.selected)
                        this.setAttribute('selected', 'selected');
                    else
                        this.removeAttribute('selected');
                });
                return oldHTML.apply(this);
            };
            //optional to override real .html() if you want
            // $.fn.html = $.fn.formhtml;
        })(jQuery);

        getProductInfo();
        bindEvents();
    }
    exports.initialize = initialize;
});
//# sourceMappingURL=ProductSearch.js.map
