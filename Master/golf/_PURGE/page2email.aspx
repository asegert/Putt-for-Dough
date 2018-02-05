<%@ Page Language="C#" ContentType="text/html" %>


<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2014
*/--%>

<script runat="server" language="c#">
		
		// ********************************* START RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //

		AutoGrossCampaign.Campaign campaign;
		AutoGrossCampaign.Responder responder;
		
		public int CampaignId;
		public string PurlId;

		public string successURL = "page3.aspx";	// <<<<<  Chancge successURL value to name of next page
		
		protected void Page_Init(Object Src, EventArgs E)
		{
// ********************************* START RESPONDER CODE - UPDATE ********************************* //

	// NOTE: ALL FORM FIELD NAMES MUST BE IDENTICAL TO TABLE FIELD NAMES AND CONTAIN STRING DATA ONLY
	// The field "nextpage" and any field names that start with two underscores (__) will be ignored.

	if (Page.IsPostBack)		// Attempt update only on postback if we have valid recipient
	{
				// Uncomment ONLY if there is a field with this name in the form it is guaranteed to have a value	
				//successURL = Request.Form["NextPage"];    // If this page can go to more than one other page

		// Update the record for the current purl with posted form data
		responder = new AutoGrossCampaign.Responder(Request.Form, PurlId);
		PurlId = responder.PurlID;  // Recapture Purl value because if something went wrong in the save, this will be blank

		// If create was successful, save the new purl in a session variable and move to the next page
		if (PurlId.Length > 0)
		{
			Session["RecipientID"] = PurlId;
			Response.Redirect(successURL);
		}
		else
		{
			__ErrorMessage.Value = responder.errorMessage;
		}

		
	}

	// ********************************* END RESPONDER CODE - UPDATE ********************************* //

				// Initialize campaign object to pull campaign data into the page with GetIt
		    if (int.TryParse(ConfigurationManager.AppSettings["CampaignId"], out CampaignId)) campaign = new AutoGrossCampaign.Campaign(CampaignId); else campaign = new AutoGrossCampaign.Campaign();

				// If have a RID query string...
				if (Request.QueryString["rid"] != null)		// Check for a query string, and if it exists...
					Session["RecipientID"] = Request.QueryString["rid"];  // Load it into the session variable.
				else if (Session["RecipientID"] == null)
					Response.Redirect(campaign.GetIt("CampaignWebSite"));		// If we also don't have an active session, redirect to the campaign's starting page

				// Record session variable in page variable	
				PurlId = Session["RecipientID"].ToString();
			
				// Make the responder object that will be uses with GetData on the page
				responder = new AutoGrossCampaign.Responder(PurlId);
			
				// Bind the page
				Page.DataBind();
		}

		// ********************************* END RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //


protected void Page_Load(Object Src, EventArgs E)
{

	// set the destination image
	
	string tableNameOfCodes = campaign.GetIt("AccessCodeTableName");
	string tableNameOfRecipients = campaign.GetIt("TableName");
	string connectString = campaign.GetIt("ConnectString");
	string purl = Session["RecipientID"].ToString();

	if (!Page.IsPostBack)
	{

		try
		{

			int AddressCount = RandomCode.RandomCode.GetAddressCount(tableNameOfRecipients, purl, connectString);

			if (AddressCount != 1 && !Convert.ToBoolean(campaign.GetIt("DemoSite")))
				Response.Redirect(campaign.GetIt("CampaignWebsite") + "/retry.aspx", true);

		}
		catch (Exception ex)
		{
			// Continue
		}
	}
	

	// If the user has already booked a test drive or if this is not the first time we have come here, don't show popup
	
	if (Session["fromGurl"] != null && Session["fromGurl"] == "True")   //True if we come to this page from the gurl pages (set on page1 and landing)
	{
		// All functions involving gurl (non-existent) people goe here

	}
	else
	{
		// All functions involving landing (existing) people goes here

	}

}
 
 
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex" />

<title>Dynamic Duo</title>
<meta name="title" content="<%#campaign.GetIt("DealerFriendlyName")%>" />


<script type="text/javascript" src="http://cdn.waysidecommunications.com/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="http://cdn.waysidecommunications.com/jquery-ui-1.8.4.custom.min.js"></script>
<script type="text/javascript" src="http://cdn.waysidecommunications.com/jquery.autotab.js"></script>
<script type="text/javascript" src="http://cdn.waysidecommunications.com/jquery.validate.js"></script> 
	
<script type="text/javascript">
	$(document).ready(function () {

		$('#form1').submit(function () {
			return true;
		});

		$('#form1').validate({
			messages: {
				pincode: { required: "Enter Number",
					digits: "Enter Number"
				}
			}
		,
			errorPlacement: function (error, element) {
				error.appendTo(element.parent("td"));
			}

		});

	});


	function randomNumber() {
		var chars = "0123456789";
		var string_length = 7;
		var randomstring = '';
		for (var i = 0; i < string_length; i++) {
			var rnum = Math.floor(Math.random() * chars.length);
			randomstring += chars.substring(rnum, rnum + 1);
		}

		$('#pincode').val(randomstring);
		return true;

	}

</script>
<script type="text/javascript">
var url = 'http://motiliti.net/LiveOnPageClient.ashx?ci=8479&pi=iddm_duo_instant';var tt= new Date().getTime();document.write('<sc'+'ript type="text/javascript" ');document.write('src="'+url+'&t'+tt+'='+tt+'">');document.write('</sc'+'ript>');
</script>


<link href='http://fonts.googleapis.com/css?family=Wendy+One' rel='stylesheet' type='text/css'>
<link href="Style.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="css/smoothness/jquery-ui-1.8.2.custom.css" rel="stylesheet" />
<link rel="icon" 
      type="image/png" 
      href="images/favicon.png" />
</head>
<body id="bodyGurl">
<form runat='server' id="form1" name='form1' method='POST' action="">
<div id="container">

<div id="crashBackground">

<div id="header"> <img src="http://images.waysideco.ca/1616/header_dynamic.png" width="1000" height="285" alt="Introducing The Dynamic Duo"/>
</div>



<div id="instantWinemail">


  <div id="ticketNumber">
  <span style="font-size:12px;"><%# /* Text ADOR */ responder.GetData("pincode") %></span>
  <br/><br/>
  
</div>

<div id="winCard">
</div>
<div id="instantWinNext">
<a href="page3.aspx"><img src="http://images.waysideco.ca/1616/button_next.png" width="250" height="96"/></a>
</div>
<!--<div id="enter15000">
<div style="padding: 10px;">
<img src="images/header_15000.png" width="420" height="80" alt="$10,000 could be yours" style="margin-top: 70px;"/>
<span style="font-family:Arial, Helvetica, sans-serif; font-size:18px;"><span style="text-transform: capitalize;"><%# /* Text ADOR */ responder.GetData("FIRST") %></span>, you have also qualified to win the Grand Prize!</span>
  <br/><br/>
  <p style="font-weight: bold;">Click on "Generate My Number" to play for the <br/><span style="font-size: 36px; color: #F00; text-transform:uppercase;">$10,000<br/>Grand Prize!</span></p>
  </div>
  </div>
<div id="numberGen">
   <!-- <input id="pincode" name="pincode" type="text" class="required digits" maxlength="7"  width="10"  value="Get your lucky number" onFocus="this.value=''" style="margin-top: 50px; margin-left: 90px;width:250px; color: #000; background: none; font-weight:bold; font-family:Arial, Helvetica, sans-serif; text-align:center; outline-width:thin; border: none;" />--></div>
  <!--<input type="image" src="images/button_baggage.png" width="170" height="45" alt="Done"  style="margin-left:10px;" onClick="return setNextPage('page4.aspx')"  />-->
<!--<div style="position: absolute; top: 465px; right: 160px;">
<a href="getnumber.aspx"><img src="images/button_generate.png" style="margin-top: -15px; border: none;" /></a>
</div>-->

</div>
<div id="footer">
     <div style="margin: 0 auto; clear: both; width:1000px;border-width:0px;text-align:center; padding-top:10px;"><span style="font-size:10px;line-height:normal;color:#FFF;font-weight:normal"><A href="disclaimer.aspx" target="_blank" style="color:#FFF">Rules and Regulations</A>  Present the validated offers at <%#campaign.GetIt("DealerFriendlyName")%>, located at</span><br />

<span style="font-size:13px;line-height:24px;color:#FFF;font-weight:normal;"><span style="font-size:14px;line-height:normal;color:#FFF;font-weight:bold;"><%#campaign.GetIt("DealerFriendlyName")%></span> <%#campaign.GetIt("Addr1")%> <%#campaign.GetIt("Addr2")%>&nbsp;&nbsp;<%#campaign.GetIt("City")%> <%#campaign.GetIt("StateOrProvince")%> <%#campaign.GetIt("PostalCode")%>&nbsp;&nbsp;|&nbsp;&nbsp;<%#campaign.GetIt("PhoneNumber")%>&nbsp;&nbsp;<%#campaign.GetIt("TollFreeNumber")%></span>
</div></div>
<div id="footer_disclaimer" style="font-size:11px; color:#FFF; margin: 0 auto;">*All offers subject to change without notice. All offers not available at all locations. Please see dealer to confirm offers and availability.</div>
</div>

<input type="hidden" name="emailsenttolead" id="emailsenttolead" value="True" />
<input type="hidden" name="emailsenttosales" id="emailsenttosales" value="True" />
<input type="hidden" id="__ErrorMessage" value="" runat="server" />
</form>

</body>
</html>









