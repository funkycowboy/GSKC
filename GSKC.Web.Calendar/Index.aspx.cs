using System;
using System.Collections.Generic;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//using Google.Apis.Auth.OAuth2;
//using Google.Apis.Auth.OAuth2;
//using Google.Apis.Calendar.v3;
//using Google.Apis.Calendar.v3.Data;
//using Google.Apis.Services;

namespace GSKC.Web.Calendar
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //try
            //{
            //    InitializeGoogleQuery(DateTime.Now);
            //}
            //catch (Exception ex)
            //{
            //    ErrorMessage.Text = ex.Message;
            //}
           
        }

        /// <summary>
        /// Initialize Google Calendar Query
        /// </summary>
        //private void InitializeGoogleQuery(DateTime theDate)
        //{
        //    const string calendarId = "b16nmnt6h8cdg3airc1mnshpe8@group.calendar.google.com";
        //    const string apiKey = "AIzaSyAAlRUvok33SD15BhoTN8UHGXCU9Qh5G0s";
        //    const string serviceAccountEmail = "490423747121-r4tb2qc4ettu73gbdpma8jij8fl3qvq7@developer.gserviceaccount.com";

        //    //Set credentials
        //    //var certificateFile = Server.MapPath("/Calendar/GoogleApiKey.p12");
        //    var certificateFile = Server.MapPath("/GoogleApiKey.p12");
        //    var certificate = new X509Certificate2(certificateFile, "notasecret", X509KeyStorageFlags.Exportable);

        //    ServiceAccountCredential credential = new ServiceAccountCredential(
        //     new ServiceAccountCredential.Initializer(serviceAccountEmail)
        //     {
        //         Scopes = new[] { CalendarService.Scope.Calendar }
        //     }.FromCertificate(certificate));

        //    // Create a CalenderService and authenticate
        //    CalendarService myService = new CalendarService(new BaseClientService.Initializer()
        //        {
        //            HttpClientInitializer = credential,
        //            ApiKey = apiKey,
        //            ApplicationName = "GSKC Calendar"
        //        });

        //    var find = myService.Events.List(calendarId);
        //    find.TimeMin = theDate;

        //    var result = find.Execute();

        //    DataTable dtEvents = BuildEventDataTable(result.Items);
        //    dtEvents.DefaultView.Sort = "StartDate ASC";

        //    //rptCalendarEvents.DataSource = dtEvents;
        //    //rptCalendarEvents.DataBind();

        //}

        /// <summary>
        /// Get First Day of Current Week
        /// </summary>
        /// <returns></returns>
        private DateTime GetFirstDayOfWeek(DateTime theDate)
        {
            DateTime firstDayOfWeek = theDate;
            DayOfWeek WeekDay = firstDayOfWeek.DayOfWeek;

            switch (WeekDay)
            {
                case DayOfWeek.Sunday:
                    break;
                case DayOfWeek.Monday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-1);
                    break;
                case DayOfWeek.Tuesday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-2);
                    break;
                case DayOfWeek.Wednesday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-3);
                    break;
                case DayOfWeek.Thursday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-4);
                    break;
                case DayOfWeek.Friday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-5);
                    break;
                case DayOfWeek.Saturday:
                    firstDayOfWeek = firstDayOfWeek.AddDays(-6);
                    break;
            }

            return firstDayOfWeek;
        }

        /// <summary>
        /// Build DataTable of "Current Week" dates
        /// </summary>
        /// <param name="theDate"></param>
        /// <returns></returns>
        private DataTable BuildCurrentWeekDataTable(DateTime theDate)
        {
            DateTime dateSun = GetFirstDayOfWeek(theDate);
            DateTime dateMon = dateSun.Add(TimeSpan.FromDays(1));
            DateTime dateTue = dateMon.Add(TimeSpan.FromDays(1));
            DateTime dateWed = dateTue.Add(TimeSpan.FromDays(1));
            DateTime dateThur = dateWed.Add(TimeSpan.FromDays(1));
            DateTime dateFri = dateThur.Add(TimeSpan.FromDays(1));
            DateTime dateSat = dateFri.Add(TimeSpan.FromDays(1));

            DataTable dt = new DataTable("CurrentWeekTable");
            dt.Columns.Add(new DataColumn("DayOfWeek"));
            dt.Columns.Add(new DataColumn("Date"));

            DataRow dr1 = dt.NewRow();
            DataRow dr2 = dt.NewRow();
            DataRow dr3 = dt.NewRow();
            DataRow dr4 = dt.NewRow();
            DataRow dr5 = dt.NewRow();
            DataRow dr6 = dt.NewRow();
            DataRow dr7 = dt.NewRow();

            dr1["DayOfWeek"] = dateSun.DayOfWeek;
            dr1["Date"] = dateSun.ToShortDateString();
            dr2["DayOfWeek"] = dateMon.DayOfWeek;
            dr2["Date"] = dateMon.ToShortDateString();
            dr3["DayOfWeek"] = dateTue.DayOfWeek;
            dr3["Date"] = dateTue.ToShortDateString();
            dr4["DayOfWeek"] = dateWed.DayOfWeek;
            dr4["Date"] = dateWed.ToShortDateString();
            dr5["DayOfWeek"] = dateThur.DayOfWeek;
            dr5["Date"] = dateThur.ToShortDateString();
            dr6["DayOfWeek"] = dateFri.DayOfWeek;
            dr6["Date"] = dateFri.ToShortDateString();
            dr7["DayOfWeek"] = dateSat.DayOfWeek;
            dr7["Date"] = dateSat.ToShortDateString();

            dt.Rows.Add(dr1);
            dt.Rows.Add(dr2);
            dt.Rows.Add(dr3);
            dt.Rows.Add(dr4);
            dt.Rows.Add(dr5);
            dt.Rows.Add(dr6);
            dt.Rows.Add(dr7);

            return dt;
        }

        /// <summary>
        /// Process Calendar Events
        /// </summary>
        /// <param name="events"></param>
        /// <returns></returns>
        //private DataTable BuildEventDataTable(IList<Event> events)
        //{

        //    DataTable dt = new DataTable("EventsTable");
        //    dt.Columns.Add(new DataColumn("Event"));
        //    dt.Columns.Add(new DataColumn("StartDate", typeof(DateTime)));
        //    dt.Columns.Add(new DataColumn("Date"));
        //    dt.Columns.Add(new DataColumn("Time"));
        //    dt.Columns.Add(new DataColumn("Location"));
        //    dt.Columns.Add(new DataColumn("Website"));
        //    dt.Columns.Add(new DataColumn("Address"));
        //    dt.Columns.Add(new DataColumn("Details"));

        //    int maxLimit = int.Parse(ConfigurationManager.AppSettings["MaxEventsCount"]);
        //    int counter = 1;

        //    DataView myDataView = null;

        //    foreach (Event evt in events)
        //    {
        //            var startDate = evt.Start.DateTime.HasValue ? evt.Start.DateTime.Value.ToShortDateString() : evt.Start.Date;
        //            var endDate = evt.End.DateTime.HasValue ? evt.End.DateTime.Value.ToShortDateString() : evt.End.Date;
        //            var startTime = evt.Start.DateTime.HasValue ? evt.Start.DateTime.Value.ToShortTimeString() : string.Empty;
        //            var endTime = evt.End.DateTime.HasValue ? evt.End.DateTime.Value.ToShortTimeString() : string.Empty;
                    
        //            DataRow dr = dt.NewRow();

        //            dr["Event"] = evt.Summary;
        //            dr["StartDate"] = startDate;
        //            dr["Date"] = startDate + (!endDate.Equals(startDate) ? " - " + endDate : string.Empty);
        //            dr["Time"] = startTime + (!string.IsNullOrEmpty(startTime) ? " - " : string.Empty) + endTime;
        //            dr["Location"] = evt.Location;

        //            if (!evt.Description.Equals(string.Empty))
        //            {
        //                var calenderInfo = evt.Description.Split('\n');

        //                dr["Website"] = calenderInfo[0].Split('=')[1];
        //                dr["Address"] = calenderInfo[1].Split('=')[1]; ;
        //                dr["Details"] = calenderInfo[2].Split('=')[1]; ;
        //            }

        //            dt.Rows.Add(dr);

        //            counter += 1;
        //    }

        //    return dt;

        //}

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void rptCalendarEvents_ItemDataBound(Object sender, RepeaterItemEventArgs e)
        {
            Repeater rpt = (Repeater)sender;

            int count = rpt.Items.Count;

            if (count > 0)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    e.Item.FindControl("rowDefault").Visible = false;
                }
            }
        }

    }
}
