/// <reference path="../../../Scripts/typings/jquery.tmpl/jquery.tmpl.d.ts" />
/// <reference path="../../../scripts/typings/jqueryui/jqueryui.d.ts" />
/// <reference path="../../../Scripts/typings/gapi/gapi.d.ts" />

import $ = require('jquery');

class Calendar {
    calendar:any;

    bindClickEvents = () => {
        $(".button-arrow").click(function () {
            //initializeModal("#Modal");
            //$("#Modal").dialog("open");

            var target = $(this).closest("div.calender-container");
            this.showHideDetails(target, !$(this).hasClass("open"));
        });
    }
    initializeModal = (modal) => {

        $(modal).dialog({
            autoOpen: false,
            show: 'fade',
            hide: 'fade',
            modal: true,
            closeText: "hide",
            closeOnEscape: false,
            close: function () {
                $("#Modal").dialog("destroy");
            },
            open: function () {
            },
            resizable: false,
            width: 400,
            buttons: [
                {
                    id: "Send",
                    text: "Send",
                    click: function () {
                    }
                }
            ]
        });
    }

    showHideDetails = (target, showAll) => {

        if (showAll) {
            $(target).find(".website,.time,.map").hide("fade");
            $(target).animate({ height: '61px' }, 1000, function () {
                //$(target).fadeOut("fast");
                //$(target).hide();
                //$(calender).hide().appendTo($(target).parent()).slideDown("slow");
                $(this.calendar).slideDown("slow");
                //bindClickEvents();
            });
        } else {
            $(target).prependTo($(target).parent());
            //$(target).siblings().slideUp(1000);

            setTimeout(function () {
                $(target).find(".website,.time,.map").fadeIn("slow");
                $(target).animate({ height: '298px' }, 1000);     //$(target).height() + 'px'

            }, 1000);

            //$("#ShowHideDetails").css("top", "415px");
        }

        $("#ShowHideDetails").toggleClass("open");
    }

    setupGoogleApi = () => {
        gapi.client.setApiKey("AIzaSyAAlRUvok33SD15BhoTN8UHGXCU9Qh5G0s");+
        gapi.client.load('calendar', 'v3', this.makeApiCall);
    }

    makeApiCall = () => {
        var request = (<any>gapi.client).calendar.events.list({
            'calendarId': 'b16nmnt6h8cdg3airc1mnshpe8@group.calendar.google.com',
            'timeMin': new Date().toISOString(),
            'singleEvents': true,
            'orderBy': 'startTime'
        });

        request.execute(function (resp) {
            var events = [];
            for (var index in resp.items) {
                var startDate = resp.items[index].start.dateTime != null ? new Date(resp.items[index].start.dateTime).toLocaleDateString() : resp.items[index].start.date;
                var endDate = resp.items[index].end.dateTime != null ? new Date(resp.items[index].end.dateTime).toLocaleDateString() : resp.items[index].end.date;
                var startTime = resp.items[index].start.dateTime != null ? new Date(resp.items[index].start.dateTime).toLocaleDateString() : "";
                var endTime = resp.items[index].end.dateTime != null ? new Date(resp.items[index].end.dateTime).toLocaleDateString() : "";

                var event = {};
                (<any>event).Event = resp.items[index].summary;
                (<any>event).StartDate = startDate;
                (<any>event).Date = startDate + (endDate != startDate ? " - " + endDate : "");
                (<any>event).Time = (startTime + (startTime != null) ? " - " : "") + endTime;
                (<any>event).Location = resp.items[index].location;

                if (resp.items[index].description != null) {
                    var calenderInfo = resp.items[index].description.split('\n');
                    (<any>event).Website = calenderInfo[0].split('=')[1];
                    (<any>event).Address = calenderInfo[1].split('=')[1];
                    (<any>event).Details = calenderInfo[2].split('=')[1];
                }

                events.push(event);
            }
            $('#CalendarTemplate').tmpl(events);//.appendTo('#calender-parent');
            //_this.bindClickEvents;            
        });
    }

}

export function initialize() {
    var calendar = new Calendar();
    //calendar.bindClickEvents();
    calendar.setupGoogleApi();
    calendar.calendar = $("#calender-parent").html();
}