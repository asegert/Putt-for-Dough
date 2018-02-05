<%@ Page Language="C#" ContentType="text/html" %>


<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2016
*/--%>

<script runat="server" language="c#">
		
		// ********************************* START RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //

		AutoGrossCampaign.Campaign campaign;
		AutoGrossCampaign.Responder responder;
		
		public int CampaignId;
		public string PurlId;

		public string successURL = "";	// <<<<<  Change successURL value to name of next page
		
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
				successURL = Request.Form["NextPage"];    // If this page can go to more than one other page

		// Update the record for the current purl with posted form data
		responder = new AutoGrossCampaign.Responder(Request.Form, PurlId);
		PurlId = responder.PurlID;  // Recapture Purl value because if something went wrong in the save, this will be blank

		// If create was successful, save the new purl in a session variable and move to the next page
		if (PurlId.Length > 0)
		{

				successURL = successURL + "?rid=" + PurlId;
			
			Session["RecipientID"] = PurlId;
			Response.Redirect(successURL);
		}
		else
		{
			__ErrorMessage.Value = responder.errorMessage;
		}

		
	}

	// ********************************* END RESPONDER CODE - UPDATE ********************************* //	


	if (!Page.IsPostBack && responder.GetData("HasBooked") == "True")  // If the user has already booked a test drive, don't show popup
	

		popUp.Visible = false;

	if (responder.GetData("hasvalidated") == "True")
		HasValidated.Value = "True";

	// set the destination image
	
	if (Session["fromGurl"] != null && Session["fromGurl"] == "True")   //True if we come to this page from the gurl pages (set on page1 and landing)
	{
		// All functions involving gurl (non-existent) people goe here

	}
	else
	{
		// All functions involving landing (existing) people goes here

	}
	
     
	

}

    [System.Web.Services.WebMethod]
		public static void SendEmailWEBSRV(string purl, string financephonearea, string financephoneprefix, string financephonesuffix)
		{
            
			string callnowSubject = "CALL ME NOW Request";

			int CampaignId;
			AutoGrossCampaign.Campaign campaign;

			if (int.TryParse(ConfigurationManager.AppSettings["CampaignId"], out CampaignId)) campaign = new AutoGrossCampaign.Campaign(CampaignId); else campaign = new AutoGrossCampaign.Campaign();
			AutoGrossCampaign.Responder responder = new AutoGrossCampaign.Responder(purl);
          	  
			NameValueCollection updateValues = new NameValueCollection();
			
			updateValues.Add("PhoneArea", financephonearea);
			updateValues.Add("PhonePrefix", financephoneprefix);
			updateValues.Add("PhoneSuffix", financephonesuffix);
			
			responder = new AutoGrossCampaign.Responder(updateValues, purl);
            
			string loanEmail = campaign.GetIt("LoanEmail");
			string salesEmail = campaign.GetIt("MainSalesEmail");
			
			responder.SendEmail(campaign.GetIt("CampaignWebsite") + "/emailcallnow.aspx?rid=" + purl, campaign.GetIt("DealerEmail"), "Campaign Headquarters", (loanEmail.Length > 0 ? loanEmail : salesEmail), "Loan Team", callnowSubject);
		}	
 
 
</script>

<!DOCTYPE html>
<html lang="en">
  <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="robots" content="noindex" />
	<title>Putt 4 Dough | Sales Event</title>
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="icons/apple-touch-icon-57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="icons/apple-touch-icon-114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="icons/apple-touch-icon-72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="icons/apple-touch-icon-144x144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="60x60" href="icons/apple-touch-icon-60x60.png" />
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="icons/apple-touch-icon-120x120.png" />
    <link rel="apple-touch-icon-precomposed" sizes="76x76" href="icons/apple-touch-icon-76x76.png" />
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="icons/apple-touch-icon-152x152.png" />
    <link rel="icon" type="image/png" href="icons/favicon-196x196.png" sizes="196x196" />
    <link rel="icon" type="image/png" href="icons/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/png" href="icons/favicon-32x32.png" sizes="32x32" />
    <link rel="icon" type="image/png" href="icons/favicon-16x16.png" sizes="16x16" />
    <link rel="icon" type="image/png" href="icons/favicon-128.png" sizes="128x128" />
    <meta name="application-name" content="&nbsp;"/>
    <meta name="msapplication-TileColor" content="#FFFFFF" />
    <meta name="msapplication-TileImage" content="icons/mstile-144x144.png" />
    <meta name="msapplication-square70x70logo" content="icons/mstile-70x70.png" />
    <meta name="msapplication-square150x150logo" content="icons/mstile-150x150.png" />
    <meta name="msapplication-wide310x150logo" content="icons/mstile-310x150.png" />
    <meta name="msapplication-square310x310logo" content="icons/mstile-310x310.png" />


	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/loveapp.css" rel="stylesheet" type="text/css" />
	<link href="css/animate.css" rel="stylesheet" type="text/css" />
	<link type="text/css" href="scripts/jquery-ui.min.css" rel="stylesheet" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script type="text/javascript" src="scripts/vendor/jquery-ui.js"></script>
	<script type="text/javascript" src="scripts/vendor/jquery.autotab.min.js"></script>
	<script src="scripts/TweenMax.min.js"></script>


<script type="text/javascript" src="scripts/bootstrap.min.js"></script>


<script type="text/javascript">
		$("#Survey8").datepicker();
	
	$(document).ready(function () {


		$('#Survey4').change(function () {
			if ($('#Survey4').val().length > 0) {
				$('#HasValidated').val("True")
			}
			else {
				$('#HasValidated').val("")
			}
		});

	});

	function setNextPage(p) {
		$('#NextPage').val(p);
		return true;
	} 
	
</script>
<script type="text/javascript">
function closeButton () {
			$('#approval').hide();
		};       
		
		
		 function PopupCenterDual(url, title, w, h) {
	// Fixes dual-screen position Most browsers Firefox
	var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
	width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

	var left = ((width / 2) - (w / 2)) + dualScreenLeft;
	var top = ((height / 2) - (h / 2)) + dualScreenTop;
	var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

	// Puts focus on the newWindow
	if (window.focus) {
	newWindow.focus();
	}
}
	

</script>

<style>
    
    html {
        max-width:100%;
        overflow-x:hidden;
        padding-top:0px;
    }

     ms-viewport {width : auto}
    
    #tab {
      width: 320px;
      height: 320px;
      position: fixed;
      float: right;
      right: -260px;
      /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#fcfff4+0,dfe5d7+40,b3bead+100;Wax+3D+%233 */
        background: #fcfff4; /* Old browsers */
        background: -moz-linear-gradient(top,  #fcfff4 0%, #dfe5d7 40%, #b3bead 100%); /* FF3.6-15 */
        background: -webkit-linear-gradient(top,  #fcfff4 0%,#dfe5d7 40%,#b3bead 100%); /* Chrome10-25,Safari5.1-6 */
        background: linear-gradient(to bottom,  #fcfff4 0%,#dfe5d7 40%,#b3bead 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fcfff4', endColorstr='#b3bead',GradientType=0 ); /* IE6-9 */
      z-index: 100000;
      -webkit-box-shadow: 0 0 25px 5px rgba(0, 0, 0, 0.75);
      box-shadow: 0 0 25px 5px rgba(0, 0, 0, 0.75);
    }
    
    #tab-container {
        margin-top:100px;
    }
    
    @media (max-width: 767px) {
       #tab-container {
        margin-top:10px;
        }
    }
    
    #phoneTab {
      display:block;
      cursor:pointer;
      width: 320px;
      height:auto !important;
      position: absolute;
      float: right;
      right:-320px;
      margin-top: 24px;
      z-index: 1010;
      padding-top:0.5rem;
      padding-bottom:0.5rem;
       /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#6219ff+0,3900b2+100 */
    background: #6219ff; /* Old browsers */
    background: -moz-linear-gradient(top,  #6219ff 0%, #3900b2 100%); /* FF3.6-15 */
    background: -webkit-linear-gradient(top,  #6219ff 0%,#3900b2 100%); /* Chrome10-25,Safari5.1-6 */
    background: linear-gradient(to bottom,  #6219ff 0%,#3900b2 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6219ff', endColorstr='#3900b2',GradientType=0 ); /* IE6-9 */
    }
    
    #phone-headline {
       color:#fff;   
    }

     #phone-button {
        cursor:pointer;
    }
    
    #stuff {
      color: #FFF;
    }
    
    #top-alert {  
        width:110%;
        height: auto;
        /* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#7d7e7d+0,666666+100 */
        background: #000; /* Old browsers */
        padding-bottom:10px;
        padding-top:15px;
        position:relative;
        display:block;
        top:0px;
        left:-5%;
        border-bottom: 1px solid #25B71A;
        -webkit-box-shadow:inset 0 -5px 15px 0 #25B71A, inset 0 -5px 30px 0 #25B71A;
        box-shadow:inset 0 -5px 15px 0 #25B71A, inset 0 -5px 30px 0 #25B71A;
    }
    
</style>


<%#campaign.GetIt("Script5")%>
</head>

<audio autoplay loop>

  <source src="sounds/main2.mp3" type="audio/mp3">
</audio>

<body class="trade-page">

    <!-- Finance Call Success Modal -->
<div class="modal fade" id="financeCall" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row">
            <h1 class="text-center kelly">Call Request Received</h1>
            <p class="leyy text-center">You will be contacted shortly by one of our credit specialists.</p>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-block btn-success" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Finance Call Error Modal -->
<div class="modal fade" id="financeError" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row">
            <h1 class="text-center kelly">An Error Occured</h1>
            <p class="leyy text-center">Please try again.</p>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-block btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



    <div class="hidden-xs">   
<div id="top-alert">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <p class="text-center kelly" style="color:#fff;font-size:20px;padding-left:10px;padding-right:10px;">
                    <span><strong>NEED A CAR? BAD CREDIT?  </strong></span><span><small>YOUR APPROVAL IS GUARANTEED! IF WE CAN'T GET YOU APPROVED, WE'LL PAY YOU $500<sup>&#42;</sup>!  </small></span>
                    <button type="button" onclick="PopupCenterDual('preapproval1.aspx?rid=<%# PurlId %>','NIGRAPHIC','640','768');" class="btn btn-danger btn-sm" style="display:inline-block;margin-left:1rem;border-color:#D1181F;">GET APPROVED</button>
                    <button type="button" onclick="closeTopAlert();" class="btn btn-default btn-sm" style="display:inline-block;margin-left:1rem;">NO THANKS</button>
                
                </p>
            </div>
        </div>
    </div>
</div>
</div>   
    
<div id="tab">
  <div class="tab-container">
      <div id="tab-close-btn" style="position:absolute;right:0px;top:0px;opacity:0;cursor:pointer;">
          <p style="color:rgba(255,255,255, 0.7);padding:10px 15px 10px 15px;">X<p>
      </div>
        <div id="tab-open-btn" style="background-color:#FD2B2E;cursor:pointer;">
            <div class="row">
                <h3 id="stuff" class="kelly text-center" style="margin-top:10PX;">BAD CREDIT - NEED A CAR?</h3>
            </div>
        </div>
      <div class="row" style="margin-top:10px;">
        <img class="center-block" src="http://images.waysideco.ca/cashino/approval_new.png" /> 
      </div>
 
    <div class="row">
        <div class="col-xs-10 col-xs-offset-1">
        <p class="text-center kelly" style="margin-top:0px;margin-bottom:10px;">YOUR APPROVAL IS GUARANTEED!<br/></>IF WE CAN'T GET YOU APPROVED,<br/> WE'LL PAY YOU <strong>$500<sup>&#42;</sup></strong>!</p>
        </div>
      </div>
 
  <div class="row">
    <div class="col-xs-10 col-xs-offset-1">
      <button onclick="PopupCenterDual('preapproval1.aspx?rid=<%# PurlId %>','NIGRAPHIC','768','768');" class="kelly btn btn-lg btn-danger btn-block" style="border-color:#D1181F;">GET APPROVED NOW</button>
    </div>
  </div>
  </div>
    
<div id="phoneTab">
  <div class="tab-container">
    <div class="row" id="phone-top-row">		
        <div class="col-xs-12">
                <img id="phone-button" src="images/callMe.png" class="img-responsive"/>
        </div>
		<div class="col-xs-12">

        </div>		
    </div>
    
		
    <div class="row phone-extras" style="margin-top:0.5rem;">
           <div class="col-xs-10 col-xs-offset-1">
                        <p class="text-center kelly">  
                                <label class=""><span style="color:#FFFFFF;">We'll call you at this number within 15 minutes*</span></label><br />
                                <input type="tel" id="financephonearea" name="phonearea" value="<%# responder.GetData("PhoneArea") %>" maxlength="3" size="3" class="form-control number" style="display:inline-block;width:70px;" /> 
                                <input type="tel" id="financephoneprefix" name="phoneprefix" value="<%# responder.GetData("PhonePrefix") %>" maxlength="3" size="3" class="form-control number" style="display:inline-block;width:70px;" /> 
                                <input type="tel" id="financephonesuffix" name="phonesuffix" value="<%# responder.GetData("PhoneSuffix") %>" maxlength="4" size="5" class="form-control number" style="display:inline-block;width:70px;" />
						</p>     
           </div>
    </div>
    <div class="row phone-extras">
            <div class="col-xs-10 col-xs-offset-1">
				    <!-- <a href="CallMeNow.aspx?rid=<%# PurlId %>" class="kelly btn btn-success btn-block" style="border-color:#006408;">CALL ME</a> -->
            	    <button onclick="financePhoneGather();" class="kelly btn btn-success btn-block" style="border-color:#006408;">CALL ME</button>
                    <p class="text-center kelly" style="margin-top:0px;"><small style="color:#fff;">* If outside of business hours we'll get in touch with you tomorrow morning.</small></p>
            </div>

    </div>

  </div>
</div> 
</div>

<div id="popUp" runat="server">
	
</div>

		<div id="approval" class="animated slideInLeft hidden-xs" style="
        left: 0px;top: 200px;width: 300px;margin: 0;padding: 0;position: fixed;z-index: 9999;display:block;  background-color:#25B71A; border-radius: 0px 20px 20px 0px; border-top:solid 3px #F4F4F4;border-right:solid 3px #F4F4F4; border-bottom:solid 3px #F4F4F4; box-shadow: 5px 5px 5px #070707;">
        	<img class="center-block" src="http://images.waysideco.ca/cashino/approval_new.png" /> 
              <h1 class=" text-center" style="color:#FFF; font-size:13px; padding-right:10px; font-weight:900;">YOUR APPROVAL IS GUARANTEED! IF WE CAN'T GET YOU APPROVED, WE'LL PAY YOU $500!</h1>
        <button type="submit" value="Pre-Approval" onclick="PopupCenterDual('preapproval1.aspx?rid=<%# PurlId %>','NIGRAPHIC','640','768');closeButton();"  alt="Continue"  class="btn-sm btn-default center-block  animated pulse infinite" style="font-weight:900; background-color:#B10C0F; color:#FFFFFF;">GET APPROVED</button>
        <button type="button" onClick="closeButton();" class="btn-sm btn-default center-block" style="font-weight:900; font-size:10px; margin-top:5px;" data-dismiss="modal"><SPAN class="animated infinite pulse">No Thanks</span></button>
        <br/>
        </div>
        </div>

	<div class="container">
 <form runat='server' id="form1" name='form1' method='POST' action="">
   <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
			<div class="row" style="">
            <img class="center-block" src="http://images.waysideco.ca/putt4dough2016/trade-logo.png" /> 
				<div class="col-xs-12 form_bg4 animated slideInDown">
					<div class="row">
                     
                        <div class="col-lg-12 col-md-12">
                         
                         <h3 class="text-center title animated pulse infinite" style="color:#FFFFFF; text-shadow: 0 0 10px #000; font-size:45px; font-weight:900;">GET THE MAX FOR YOUR TRADE GUARANTEED!<br/><strong><span class="title animated flash infinite" style="color:#F8BE13; font-size:35px; font-weight:900;">GET OUT OF THE SANDTRAP AND DRIVE A NEW CAR <br/> FOR THE SAME PAYMENT OR LESS!</span></strong></h3>
                        </div>
                    </div>
                    <hr style="border-color:#FFCB05;opacity:0.25;" />
					
					<div class="row">
						<div class="col-sm-12 col-lg-12">
							<div class="row">
								<div class="form-group col-sm-4  title">
									<label ><span style="color:#FFFFFF; font-size:25px; font-weight:900;"><%#campaign.GetIt("SurveyQuestion4")%></span></label>
									<input id="Survey4" name="Survey4" type="text" placeholder="Your Vehicle Make" value='<%# /* Text ADOR */ responder.GetData("survey4") %>' class="form-control 0" />
								</div>
								<div class="form-group col-sm-4  title ">
									<label ><span style="color:#FFFFFF; font-size:25px;font-weight:900; "><%#campaign.GetIt("SurveyQuestion5")%></span></label>
									<input id="Survey5" name="Survey5" type="text" placeholder="Your Vehicle Model" value='<%# /* Text ADOR */ responder.GetData("survey5") %>' class="form-control 0" />
								</div>
								<div class="form-group col-sm-4  title ">
									<label ><span style="color:#FFFFFF; font-size:25px;font-weight:900;"><%#campaign.GetIt("SurveyQuestion6")%></span></label>
									<input id="Survey6" name="Survey6" type="text" placeholder="Vehicle Mileage in KMS" value='<%# /* Text ADOR */ responder.GetData("survey6") %>' class="form-control 0" />
								</div>
							</div>

							<div class="row">
								<div class="form-group col-sm-4  title ">
									<label ><span style="color:#FFFFFF; font-size:25px;font-weight:900;"><%#campaign.GetIt("SurveyQuestion7")%></span></label>
									<select id="Survey7" name="Survey7" class="form-control" >
										<option value="">Select Amount</option>
										<option value="$0-$200" <%# responder.GetData("Survey7").ToLower() == "$0-$200" ? "selected='selected'" : "" %>>$0-$200</option>
										<option value="$200-$400" <%# responder.GetData("Survey7").ToLower() == "$200-$400" ? "selected='selected'" : "" %>>$200-$400</option>
										<option value="$400-$600" <%# responder.GetData("Survey7").ToLower() == "$400-$600" ? "selected='selected'" : "" %>>$400-$600</option>
										<option value="$600+" <%# responder.GetData("Survey7").ToLower() == "$600+" ? "selected='selected'" : "" %>>$600+</option>
									</select>
								</div>
								<div class="form-group col-sm-4  title ">
									<label ><span style="color:#FFFFFF; font-size:25px;font-weight:900;"><%#campaign.GetIt("SurveyQuestion8")%></span></label>
									<input id="Survey8" name="Survey8" type="text" placeholder="Vehicle Pay Off Date" value='<%# /* Text ADOR */ responder.GetData("survey8") %>' class="form-control 0" />
								</div>
								<div class="form-group col-sm-4  title ">
									<label ><span style="color:#FFFFFF; font-size:25px;font-weight:900;"><%#campaign.GetIt("SurveyQuestion9")%></span></label>
									<input id="Survey9" name="Survey9" type="text" placeholder="Current Lender" value='<%# /* Text ADOR */ responder.GetData("survey9") %>' class="form-control 0" />
								</div>
							</div>
					
						</div>
						
							<div class="row">
							<div class="col-xs-12">
								<h4 class="text-center 0 title" style="color:#fff; font-size:20px;">Thinking of buying a new vehicle? Choose from one of our special <span style="text-decoration:underline;"><strong>Online ONLY</strong></span> offers.</h4>
								<br/>
                                </div>
                                </div>
                                
                                
                                <div class="row">
                                <div class="col-lg-4 col-lg-push-2 col-sm-4 col-sm-push-1 col-xs-push-1" >
								
									<asp:Panel ID="pnlOffer1" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue1"))%>'>
										<label for="promo1"  ><input type="radio" style="color:#FF07F6;" name="Offer" value='<%#campaign.GetIt("MainOfferValue1")%>' id="promo1"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue1") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue1")%></span></label><br />
									</asp:Panel>
									<asp:Panel ID="pnlOffer2" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue2"))%>'>
										<label for="promo2"  ><input type="radio" name="Offer" value='<%#campaign.GetIt("MainOfferValue2")%>' id="promo2"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue2") ? "checked=\"checked\"" : "" %> /><span style="color:#F8BE13; font-size:16px; font-weight:900;"> <%#campaign.GetIt("MainOfferValue2")%></span></label><br />
									</asp:Panel>
									<asp:Panel ID="pnlOffer3" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue3"))%>'>
										<label for="promo3"  ><input type="radio"  name="Offer" value='<%#campaign.GetIt("MainOfferValue3")%>' id="promo3"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue3") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue3")%></span></label><br />
									</asp:Panel>
                                    </div>
                                    <div class="col-lg-4 col-lg-push-3 col-sm-4 col-sm-push-2 col-xs-push-1">
                                    	<asp:Panel ID="pnlOffer4" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue4"))%>'>
										<label for="promo4"  ><input type="radio"  name="Offer" value='<%#campaign.GetIt("MainOfferValue4")%>' id="promo4"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue4") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue4")%></span></label><br />
									</asp:Panel>
									<asp:Panel ID="pnlOffer5" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue5"))%>'>
										<label for="promo5"  ><input type="radio" name="Offer" value='<%#campaign.GetIt("MainOfferValue5")%>' id="promo5"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue5") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue5")%></span></label><br />
									</asp:Panel>
<asp:Panel ID="pnlOffer6" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue6"))%>'>
										<label for="promo6"  ><input type="radio" name="Offer" value='<%#campaign.GetIt("MainOfferValue6")%>' id="promo6"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue6") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue6")%></span></label><br />
									</asp:Panel>
<asp:Panel ID="pnlOffer7" runat="server" Visible='<%#!string.IsNullOrEmpty(campaign.GetIt("MainOfferValue7"))%>'>
										<label for="promo7"  ><input type="radio"  name="Offer" value='<%#campaign.GetIt("MainOfferValue7")%>' id="promo7"  <%# responder.GetData("Offer")==campaign.GetIt("MainOfferValue7") ? "checked=\"checked\"" : "" %> /> <span style="color:#F8BE13; font-size:16px; font-weight:900;"><%#campaign.GetIt("MainOfferValue7")%></span></label><br />
									</asp:Panel>
								</div>
                         
							</div>
						

					
				
							<hr style="border-color:#FFCB05;opacity:0.25;"/>
							
			
					<div class="row">
						<p id="page1next" class="text-center 0">
								 <input type="submit" value="GET MORE!" alt="Done" style="background-color:#006838; border:#F8BE13 3px solid; font-size:30px;" onClick="return setNextPage('page5.aspx')" class="btn  btn-success btn-lg title " />
								
								<input type="submit" value="No Thanks" alt="Done" onClick="return setNextPage('page5.aspx')" style="background-color:#969696; color:#000;" class="btn  btn-default btn-md kelly" />
						</p>
					</div>
					
				</div><!-- / .col -->
			</div><!-- / .row -->


		<asp:HiddenField ID="HasValidated" runat="server" />
		<input type="hidden" id="NextPage" name="NextPage" value="" />
		
		
		<input type="hidden" id="__ErrorMessage" value="" runat="server" />

		</form>

		<br/>
		<br/>


	</div>

<div class="container">
	<div class="row">
		<div class="col-xs-12">
					<footer class="kelly 0">
						<p class="text-center" style="margin-top:30px; padding:10px; text-shadow: 0 0 10px #000;">
							<a href="disclaimer.aspx" target="_blank" style="color:#C9C9C9;  text-decoration:underline;">Rules and Regulations</a><br/>
						<span style="color:#FFFFFF;">Present the validated offers at</span><br />
							<span style="color:#FFFFFF;"><strong><%#campaign.GetIt("DealerFriendlyName")%></strong> <%#campaign.GetIt("Addr1")%> <%#campaign.GetIt("Addr2")%> <%#campaign.GetIt("City")%> <%#campaign.GetIt("StateOrProvince")%> <%#campaign.GetIt("PostalCode")%>&nbsp;&nbsp;|&nbsp;&nbsp;<%#campaign.GetIt("PhoneNumber")%>&nbsp;&nbsp;<%#campaign.GetIt("TollFreeNumber")%></span>
							<br/>
							<span style="color:#FFFFFF;">*All offers subject to change without notice. All offers not available at all locations. Please see dealer to confirm offers and availability.
							<br>IDDM &copy; 2016</span>
						</p>
					</footer>
		</div>
	</div>

</div>

<script>

	var intro = document.getElementsByClassName("intro"),
        	tl = new TimelineMax();

	tl.set(intro, { scale: 0.5, opacity: 0, force3D: true });

	tl.staggerTo(intro, 2, { scale: 1, opacity: 1, delay: 1.0, ease: Elastic.easeOut, force3D: true }, 0.2);



	
	function PopupCenterDual(url, title, w, h) {
		// Fixes dual-screen position Most browsers Firefox
		var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
		var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
		width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
		height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

		var left = ((width / 2) - (w / 2)) + dualScreenLeft;
		var top = ((height / 2) - (h / 2)) + dualScreenTop;
		var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

		// Puts focus on the newWindow
		if (window.focus) {
			newWindow.focus();
		}
	}

	// FINANCE PART3
	//controls for the financing side-tab
	TweenMax.set($("#tab"), { scale: 0.85, rotation: "-90", transformOrigin: "0 300" });

	$(document).ready(function () {
		TweenMax.to($("#tab"), 0.3, { scale: 1, rotation: "0", right: "0", ease: Circ.easeInOut, delay: 2 })
		TweenMax.to($("#phoneTab"), 0.3, { right: "0", ease: Circ.easeInOut, delay: 2.25 })
		TweenMax.to($("#tab-close-btn"), 0.3, { opacity: 1, ease: Circ.easeInOut, delay: 2.5 })
	})

	$("#tab-close-btn").click(function () {
		TweenMax.to($("#phoneTab"), 0.15, { right: "-320", ease: Circ.easeInOut });
		TweenMax.to($("#tab"), 0.25, { scale: 0.85, rotation: "-90", right: "-260", delay: 0.25, ease: Circ.easeInOut });
		tlPhone.set(phoneTopRow, { display: "block", opacity: 1 });
		tlPhone.set(phoneExtras, { display: "none", opacity: 0 });
		TweenMax.to($("#tab-close-btn"), 0.3, { opacity: 0, ease: Circ.easeInOut });
	});

	$("#tab-open-btn").click(function () {
		TweenMax.to($("#tab"), 0.3, { scale: 1, rotation: "0", right: "0", ease: Circ.easeInOut })
		TweenMax.to($("#phoneTab"), 0.3, { right: "0", ease: Circ.easeInOut, delay: 0.25 })
		TweenMax.to($("#tab-close-btn"), 0.3, { opacity: 1, ease: Circ.easeInOut, delay: 0.5 })
	});

	var phoneExtras = document.getElementsByClassName("phone-extras"),
        phoneTopRow = document.getElementById("phone-top-row"),
        tlPhone = new TimelineMax();

	tlPhone.set(phoneExtras, { display: "none", opacity: 0 });

	// CALL ME NOW
	$('#phone-button').click(function () {

		tlPhone.to(phoneTopRow, 0.2, { opacity: 0, display: "none" });
		tlPhone.set(phoneExtras, { display: "block" });
		tlPhone.staggerTo(phoneExtras, 0.5, { opacity: 1, delay: 0.2 }, 0.1);
	});

	function financePhoneGather() {
		var financephonearea = $("#financephonearea").val();
		var financephoneprefix = $("#financephoneprefix").val();
		var financephonesuffix = $("#financephonesuffix").val();

		return sendFinanceEmail(financephonearea, financephoneprefix, financephonesuffix);
	}

	function sendFinanceEmail() {

		PageMethods.SendEmailWEBSRV('<%= PurlId %>', $("#financephonearea").val(), $("#financephoneprefix").val(), $("#financephonesuffix").val(), onSucess, onError);
		function onSucess(result) {
			closeButton();
			TweenMax.to($("#phoneTab"), 0.15, { right: "-320", ease: Circ.easeInOut });
			TweenMax.to($("#tab"), 0.25, { scale: 0.85, rotation: "-90", right: "-260", delay: 0.25, ease: Circ.easeInOut });
			tlPhone.set(phoneTopRow, { display: "block", opacity: 1 });
			tlPhone.set(phoneExtras, { display: "none", opacity: 0 });
			TweenMax.to($("#tab-close-btn"), 0.3, { opacity: 0, ease: Circ.easeInOut });
			setTimeout(successModal, 750);
		}
		function onError(result) {
			closeButton();
			TweenMax.to($("#phoneTab"), 0.15, { right: "-320", ease: Circ.easeInOut });
			TweenMax.to($("#tab"), 0.25, { scale: 0.85, rotation: "-90", right: "-260", delay: 0.25, ease: Circ.easeInOut });
			tlPhone.set(phoneTopRow, { display: "block", opacity: 1 });
			tlPhone.set(phoneExtras, { display: "none", opacity: 0 });
			TweenMax.to($("#tab-close-btn"), 0.3, { opacity: 0, ease: Circ.easeInOut });
			setTimeout(errorModal, 750);
		}
	}

	function successModal() {
		$('#financeCall').modal('show');
	}

	function errorModal() {
		$('#financeError').modal('show');
	}

	//top-alert
	var topTl = new TimelineMax();
	var topAlert = document.getElementById("top-alert");
	var topAlertHeight = $("#top-alert").height();

	//var topAlertHeight = topAlert.height();
	topTl.set(topAlert, { top: -(topAlertHeight + 26) });

	topTl.to(topAlert, 0.5, { top: 0, delay: 3, ease: Circ.easeInOut });
	function closeTopAlert() {
		topTl.to(topAlert, 0.5, { top: -(topAlertHeight), ease: Circ.easeInOut })
	}

	//FINANCE PART 3 END   	

</script>
<script>
$("#Survey8").datepicker({
    minDate: 0,
});
</script>
<script type="text/javascript">
	



$("#Survey6").keypress(function(e) {
  if (String.fromCharCode(e.which).match(/[^0-9\x08 ]/)) {
    e.preventDefault();
  }
});


</script>

</body>
</html>