import ko = require('knockout');
import mapping = require('knockout.mapping');
import $ = require('jquery');
import bindings = require('knockout.custom.bindings');

export function initialize() {    
    (<any>bindings).initializeBindings();
    bindEvents();
}

function bindEvents(){

        $(function(){
            $('#ProductSearchButton').click(function () {
                var $this = $(".sidenav");
                if ($this.hasClass("on")) {
                    $this.removeClass("on").addClass("off");
                } else {
                    $this.removeClass("off").addClass("on");
                }
            });

            $('#SlideIndicatorButton').click(function () {
                var $this = $(".sidenav");
                if ($this.hasClass("on")) {
                    $this.removeClass("on").addClass("off");
                    $this.removeClass("glyphicon-triangle-right").addClass("glyphicon-triangle-left");

                } else {
                    $this.removeClass("off").addClass("on");
                    $this.removeClass("glyphicon-triangle-left").addClass("glyphicon-triangle-right");
                }

            });

            function lockScroll() {
                $(document).bind("touchstart", function (event) {
                    event.preventDefault();
                });
                $(document).bind("touchmove", function (event) {
                    event.preventDefault();
                });
            }

            function unLockScroll() {
                $(document).unbind("touchstart");
                $(document).unbind("touchmove");

            }

            function changeOrientation(event) {
                $("#landscape").show();
                $("#rotateplease").show();
            
                if ($(window).width() > $(window).height()) {                
                    lockScroll();
                }
                else {
                    unLockScroll();
                }
            }

            $(window).on("orientationchange", function () {
                changeOrientation(event);
            });
        });

}
