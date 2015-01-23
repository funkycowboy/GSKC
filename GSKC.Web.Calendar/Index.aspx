<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GSKC.Web.Calendar.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
          
        .calender-container 
        {
            border: 2px solid #3a3a3a; 
            border-radius: 10px;             
            margin-bottom: 5px; 
            padding:5px; 
            background-color: gray;
            color: #e7e7e7;
            /*cursor: pointer;*/
            font-family: Arial;
        }  
        
            .calender-container:hover .start-date
            {
                background-color: #f39d40;
            }
         
            .calender-container span
            {            
                font-family: Arial;
                font-size: 14px;            
            }
            
            .calender-container div
            {            
                margin-bottom: 4px;
            }
        
            .calender-container .event-name 
            {            
                font-size: 14px;
                font-weight: bold;
            }  
            
            .calender-container .start-date 
            {            
                font-size: 15px;
                font-weight: bold;
                color: #FFF;
                /*border-bottom: 1px dotted #FFF;*/
                padding: 0px;
                background-color: #3a3a3a;
                border-radius: 5px;
                border-top-left-radius: 0px;
                border-bottom-left-radius: 0px;
                height: 20px;
                
            }                                   
            
        .calender-image
        {
            width: 36px;
            height: 18px;
            border: 1px solid #3a3a3a;
        }
        
        .more-info {            
            color: #000066;
            text-decoration: underline;
            font-size: 10px;
        }
        
        .button-arrow 
        {
            position:absolute;
            /*z-index:100;*/ 
            right: 7px;
            top:45px; 
            background: url(/Images/ui-icons_454545_256x240.png) 608px -192px;
            width:16px; 
            height: 16px;
            cursor: pointer;
            background-color: #FFF;
            border-radius: 3px;
            border: 2px solid #f08e02;
        }
        
        .open 
        {
            background-position: 640px -192px;
        }                
        
        body 
        {
            background-color: #F1F1E4;
            margin: 0;
        }
                                        
    </style>

    <link rel="stylesheet" href="/Content/jquery-ui.css" type="text/css" />

    <% //if(Request.ServerVariables["HTTP_HOST"].Contains("localhost")){%>
        <!-- Use Local scripts -->
        <!--<script language="javascript" type="text/javascript" src="/Scripts/jquery-1.7.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="/Scripts/jquery-ui.1.8.18.min.js"></script>-->
    <% //}else{ %>
        <!-- Use Google CDN scripts -->
        <script language="javascript" type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script language="javascript" type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
        <script language="javascript" type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.templates/beta1/jquery.tmpl.js"></script>
    <%// } %>

    <script type="text/javascript" src="https://apis.google.com/js/client.js?onload=OnLoadCallback"></script>
    <script type="text/javascript">
        var gskc = {};

        gskc.Calender = {
            calender: null,
            bindClickEvents: function () {
                $(".button-arrow").click(function () {
                    //gskc.Calender.initializeModal("#Modal");
                    //$("#Modal").dialog("open");

                    var target = $(this).closest("div.calender-container");
                    gskc.Calender.showHideDetails(target, !$(this).hasClass("open"));
                });

                //                $(".view-all").click(function (e) {
                //                    gskc.Calender.showHideDetails($(this).closest("div.calender-container"), true);
                //                    //e.stopPropagation();
                //                });
            },
            initializeModal: function (modal) {

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
                        //$(this).siblings('.ui-dialog-buttonpane').find('button:eq(0)').focus();

                        //                        $(this).keydown(function (event) {
                        //                            if (event.keyCode == 13) {
                        //                                $(this).parent().find("button:eq(0)").trigger("click");
                        //                            }
                        //                        });

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
            },
            showHideDetails: function (target, showAll) {

                if (showAll) {
                    $(target).find(".website,.time,.map").hide("fade");
                    $(target).animate({ height: '61px' }, 1000, function () {
                        //$(target).fadeOut("fast");
                        //$(target).hide();
                        //$(gskc.Calender.calender).hide().appendTo($(target).parent()).slideDown("slow");
                        $(gskc.Calender.calender).slideDown("slow");
                        //gskc.Calender.bindClickEvents();
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
            },
            setupGoogleApi: function(){
                gapi.client.setApiKey("AIzaSyAAlRUvok33SD15BhoTN8UHGXCU9Qh5G0s");
                gapi.client.load('calendar', 'v3', gskc.Calender.makeApiCall);
            },
            makeApiCall: function () {
                var request = gapi.client.calendar.events.list({
                    'calendarId': 'b16nmnt6h8cdg3airc1mnshpe8@group.calendar.google.com',
                    'timeMin': new Date().toISOString(),
                    'singleEvents' : true,
                    'orderBy': 'startTime'
                });

                request.execute(function (resp) {
                    var events = [];
                    for(var index in resp.items){                 
                        var startDate = resp.items[index].start.dateTime != null ? new Date(resp.items[index].start.dateTime).toLocaleDateString() : resp.items[index].start.date;
                        var endDate = resp.items[index].end.dateTime != null ? new Date(resp.items[index].end.dateTime).toLocaleDateString() : resp.items[index].end.date;
                        var startTime = resp.items[index].start.dateTime != null ? new Date(resp.items[index].start.dateTime).toLocaleDateString() : "";
                        var endTime = resp.items[index].end.dateTime != null ? new Date(resp.items[index].end.dateTime).toLocaleDateString() : "";

                        var event = {};
                        event.Event = resp.items[index].summary;
                        event.StartDate = startDate;
                        event.Date = startDate + (endDate != startDate ? " - " + endDate : "");
                        event.Time = (startTime + (startTime != null) ? " - " : "") + endTime;
                        event.Location = resp.items[index].location;
                        
                        if (resp.items[index].description != null) {
                            var calenderInfo = resp.items[index].description.split('\n');
                            event.Website = calenderInfo[0].split('=')[1];
                            event.Address = calenderInfo[1].split('=')[1];
                            event.Details = calenderInfo[2].split('=')[1];
                        }

                        events.push(event);
                    }
                    

                    $('#CalendarTemplate').tmpl(events).appendTo('body');
                    gskc.Calender.bindClickEvents();
                });                               
            }
        };

        $(function () {
            gskc.Calender.calender = $("#calender-parent").html();            
        });
          
      </script>

      

</head>
<body onload="gskc.Calender.setupGoogleApi();">
    <!--<input type="button" onclick="gskc.Calender.setupGoogleApi();" value="Test" /><br />-->

    <asp:Label runat="server" ID="ErrorMessage"></asp:Label>
    <form id="form1" runat="server">   
        <div id="calender-parent">             
            <script id="CalendarTemplate" type="x-jquery-tmpl">  
               
                <div class="calender-container" style="position: relative">
                        <div class="start-date">					    
					        <div style="display: inline-block; padding-left: 0"><img src="http://www.gatlinandsonsknifecompany.com/Images/InterfaceElements/IconCalendar_2.gif" style="vertical-align: middle" class="calender-image"/> </div>
					        <div style="display: inline-block"><label ID="lblStartDate">${Date}</label></div>
				        </div>
				        <div class="name">
					        <label ID="lblEventTitle" class="event-name">${Event}</label><br />
					        <label ID="lblLocation">${Location}</label>
				        </div>
                        <div class="time" style="display: none">
                            <span style="display:block; font-weight:bold">Time:</span><span>${Time}</span>
                        </div>
                        <div class="website" style="display: none">                           
                            <span style="display:block;">Click <a href='${Website}' ID="Label1" style="color: #e7e7e7" target="_blank">here</a> for more information.</span>  
                        </div>                                                
                        <div class="map" style="width:100%; height:180px; margin: 10px 0; display: none; text-align: right">
                            <!-- Google Map -->
                            <iframe style="width: 100%; height:150px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=${Address}&ie=UTF8&z=15&t=m&iwloc=near&output=embed"></iframe>
                            <a target="_blank" style="font-size:11px; color: #e7e7e7; display:inline-block; margin-top: 5px" href="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=${Address}&ie=UTF8&z=15&t=m&iwloc=near" class="more-info">View Larger Map &raquo;</a>
                        </div>  
                        <div id="ShowHideDetails" class="button-arrow open" title="Click for more information"></div>                                                                                
                 </div>
                	
            </script>	
        </div>				        					
     </form>       
               
</body>
</html>

