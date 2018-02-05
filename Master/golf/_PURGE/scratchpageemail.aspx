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

		public string successURL = "page2email.aspx";	// <<<<<  Chancge successURL value to name of next page
		
		protected void Page_Init(Object Src, EventArgs E)
		{

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

    System.Web.HttpBrowserCapabilities browser = Request.Browser;
		string browserName = browser.Browser;
		int browserVersion = Convert.ToInt32(browser.MajorVersion);

	
		if (browserName == "IE" && browserVersion < 9)
		{
			scratcher.Visible = false;
			circle.Visible = true;
		}
	
}		

		
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="robots" content="noindex" />
<title>Dynamic Duo</title>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.js"></script>
<script type="text/javascript" src="http://cdn.waysidecommunications.com/jquery.validate.js"></script> 
<script type="text/javascript" src="scripts/scratcheremail.js"></script> 

    <script type="text/javascript">
    	$(document).ready(function () {

    		$('#form1').validate({
    			messages: {
    				pincode: { required: "Enter Number",
    					digits: "Enter Number"
    				}
    			}
		,
    			errorPlacement: function (error, element) {
    				error.appendTo(element.parent("div"));
    			 }

        });

    });

			
			function randomNumber() {
        var chars = "0123456789";
        var string_length = 6;
        var randomstring = '';
        for (var i = 0; i < string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum, rnum + 1);
        }

        $('#pincode').val(randomstring);
        return true;

    	}

</script>


<link href='http://fonts.googleapis.com/css?family=Knewave' rel='stylesheet' type='text/css'>
<link href="Style.css" rel="stylesheet" type="text/css" />
<link rel="icon" 
      type="image/png" 
      href="images/favicon.png" />

</head>
<!--slider script-->

<script type="text/javascript">
var url = 'http://motiliti.net/LiveOnPageClient.ashx?ci=8479&pi=iddm_duo_scratchemail';var tt= new Date().getTime();document.write('<sc'+'ript type="text/javascript" ');document.write('src="'+url+'&t'+tt+'='+tt+'">');document.write('</sc'+'ript>');
</script>

<body id="bodyGurl">
<form runat='server' id="form1" name='form1' method='POST' action="">   
<div id="container">

<div id="crashBackground">

<div id="header"> <img src="http://images.waysideco.ca/1616/header_dynamic.png" width="1000" height="285" alt="Introducing The Dynamic Duo"/>
</div>


<div id="page2next">
		<input type="image" src="http://images.waysideco.ca/1616/button_claim.png" Height="231" Width="250"  alt="Claim my prize" />
</div>

<div id="buttonGenerate">
    <input type="image" src="http://images.waysideco.ca/1616/button_ticketnumber.png" style=" margin-top: -10px;width:250px;" onClick="randomNumber();" />
</div>

<div id="scratchNote">
<div style="padding: 10px; margin-top: 30px;">
<span style="text-transform: capitalize;"><%# /* Text ADOR */ responder.GetData("FIRST") %>,</span>
</div>
</div>

<div id="scratchNote2">

<img src="http://images.waysideco.ca/1616/example.png" width="223" height="130" alt="Sample image"/>
<img src="http://images.waysideco.ca/1616/enterticketnumber.png" width="220" height="24" alt="Enter your Ticket number" style="margin-top: -30px;"/>
	<input id="pincode" name="pincode" class="required pincode digits"  onFocus="this.value=''" type="text" value="Enter your ticket #" style="width: 220px; font-weight: bold; padding-top: -20px;" maxlength="7"/>
</div>


<div id="scratchHere">
<img src="http://images.waysideco.ca/1616/scratch_here.gif" width="196" height="167" alt="Scratch Here"/>
</div>
<div id="scratch">
  <!--Scratch Card Background-->
  </div>
  
  <div id="scratcher" runat="server">
     <canvas id="maincanvas">
		</canvas>
</div> <!-- main -->

  <div id="circle" runat="server" visible="false">
<a onClick="document.getElementById('PopScratch').style.display = 'block'"><img src="http://images.waysideco.ca/1616/foreground2.png" width="80" height="80" alt="Click here" title="Click here"/></a>
<div id="PopScratch">
<img src="http://images.waysideco.ca/1616/background.png" width="80" height="80" alt="Your Symbol" Title="Your Symbol" />
</div>
</div>

<div id="loading"><p>[Loading canvas images<span class="blink">...</span>]</div>


</div>


<div id="footer">
     <div style="margin: 0 auto; clear: both; width:1000px;border-width:0px;text-align:center; padding-top:30px;"><span style="font-size:10px;line-height:normal;color:#FFF;font-weight:normal"><A href="disclaimer.aspx" target="_blank" style="color:#FFF">Rules and Regulations</A>  Present the validated offers at <%#campaign.GetIt("DealerFriendlyName")%>, located at</span><br />

<span style="font-size:13px;line-height:24px;color:#FFF;font-weight:normal;"><span style="font-size:14px;line-height:normal;color:#FFF;font-weight:bold;"><%#campaign.GetIt("DealerFriendlyName")%></span> <%#campaign.GetIt("Addr1")%> <%#campaign.GetIt("Addr2")%>&nbsp;&nbsp;<%#campaign.GetIt("City")%> <%#campaign.GetIt("StateOrProvince")%> <%#campaign.GetIt("PostalCode")%>&nbsp;&nbsp;|&nbsp;&nbsp;<%#campaign.GetIt("PhoneNumber")%>&nbsp;&nbsp;<%#campaign.GetIt("TollFreeNumber")%></span>
</div></div>
<div id="footer_disclaimer" style="font-size:11px; color:#FFF; margin: 0 auto;">*All offers subject to change without notice. All offers not available at all locations. Please see dealer to confirm offers and availability.</div>
</div>
</div>
<input type="hidden" id="__ErrorMessage" value="" runat="server" />
</form>
</body>
</html>