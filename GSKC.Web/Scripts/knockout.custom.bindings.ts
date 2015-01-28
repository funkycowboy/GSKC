import ko = require('knockout');

export function initializeBindings(){


    ko.bindingHandlers.afterHtmlRender = {
        update: function (element, valueAccessor, allBindings) {
            // check if element has 'html' binding
            if (!allBindings().foreach) return;
            // get bound callback (don't care about context, it's ready-to-use ref to function)
            var callback = valueAccessor();
            // fire callback with new value of an observable bound via 'html' binding
            callback(element);
        }
    };

    //ko.bindingHandlers.currency = {
    //    symbol: ko.observable('$'),
    //    update: function (element, valueAccessor, allBindingsAccessor) {
    //        return ko.bindingHandlers.text.update(element, function () {
    //            var value = +(ko.utils.unwrapObservable(valueAccessor()) || 0),
    //                symbol = ko.utils.unwrapObservable(allBindingsAccessor().symbol === undefined
    //                    ? allBindingsAccessor().symbol
    //                    : ko.bindingHandlers.currency.symbol);
    //            return symbol + value.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
    //        });
    //    }
    //};
}
