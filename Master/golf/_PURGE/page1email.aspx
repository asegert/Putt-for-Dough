<%@ Page Language="C#" ContentType="text/html" %>

<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2014
*/--%>

<script runat="server" language="c#">
		
	// ********************************* START RESPONDER INITIALIZATION CODE - ADD NEW OR NO RESPONDER ********************************* //

	AutoGrossCampaign.Campaign campaign;
	AutoGrossCampaign.Responder responder;
		
	public int CampaignId;
	public string PurlId;

	public string successURL = "scratchpageemail.aspx";	// <<<<<  Chancge successURL value to name of next page
		
	protected void Page_Init(Object Src, EventArgs E)
	{
	
		// Initialize campaign object to pull campaign data into the page with GetIt
		if (int.TryParse(ConfigurationManager.AppSettings["CampaignId"], out CampaignId)) campaign = new AutoGrossCampaign.Campaign(CampaignId); else campaign = new AutoGrossCampaign.Campaign();
			
		// Bind the page
		Page.DataBind();
	}


		protected void Page_Load(Object Src, EventArgs E)
		{

                     // ***************************** START RESPONDER CODE - ADD ********************************* //
                      // NOTE: ALL FORM FIELD NAMES MUST BE IDENTICAL TO TABLE FIELD NAMES AND CONTAIN STRING DATA ONLY
                           // The field "nextpage" and any field names that start with two underscores (__) will be ignored.

                     if (Page.IsPostBack)
                     {
                     	//successURL = Request.Form["NextPage"];    // Uncomment ONLY if this page can go to more than one other page and contains a hidden filed with the name “NextPage”

                     	// Create new responder record based on form data
                           responder = new AutoGrossCampaign.Responder(Request.Form);
                           PurlId = responder.PurlID;
 
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
                     // ********************************* END RESPONDER CODE - ADD ********************************* //   

			Session["fromGurl"] = "True";

			System.Web.HttpBrowserCapabilities browser = Request.Browser;
			Survey10.Value = browser.Browser + " " + browser.Version;
			Survey11.Value = browser.Platform;			
			
						// If we have a postal code and not a blankd or "Enter your postal code" text, save it in the hidden field
			if (!(Request.QueryString["PC"] == null) && Request.QueryString["PC"].ToString().Length < 11)
			{
				PC.Value = Request.QueryString["PC"].ToString();

				// If we have Lat and Lon data save them in the hidden field
				if (!(Request.QueryString["Lat"] == null) && !(Request.QueryString["Lon"] == null))
				{
					Lat.Value = Request.QueryString["Lat"];
					Lon.Value = Request.QueryString["Lon"];
				}
				// If we don't have Lat and Lon, we do have a postal code at this point, so we geocode it
				else
				{
					Geolocation geoLoc = campaign.getLatLon(Request.QueryString["PC"].ToString());
					Lat.Value = geoLoc.Lat.ToString();
					Lon.Value = geoLoc.Lon.ToString();
				}
			}
	
				if (!(Request.QueryString["S"] == null) && Request.QueryString["S"].Length > 1)  // record the source in hidden field (defaults to Mail)
				{
						Source.Value = Request.QueryString["S"].ToString();
				}
				else
				{
						Source.Value = "Mail";
				}

				if (!(Request.QueryString["Rep"] == null))  // record the sales rep in hidden filed
				{
						SalesRep.Value = Request.QueryString["Rep"].ToString();
				}

				if (!(Request.QueryString["R"] == null))   // record if we have a sender for this responder (from facebook or twitter)
				{
					SenderRID.Value = Request.QueryString["R"].ToString();
				}

				if (!(Request.QueryString["I"] == null))   // record if we have a sender for this responder (from facebook or twitter)
				{
					ReferrerID.Value = Request.QueryString["I"].ToString();
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
 

<script>
	$(document).ready(function () {


		$('#phonearea').autotab({ target: 'phoneprefix', format: 'numeric' });
		$('#phoneprefix').autotab({ target: 'phonesuffix', format: 'numeric', previous: 'phonearea' });
		$('#phonesuffix').autotab({ previous: 'phoneprefix', format: 'numeric' });


		$('#form1').validate({
			messages: {
				first: { required: "Enter First" },
				last: { required: "Enter Last" },
				email: { required: "Enter Email" },
				addr1: { required: "Enter Address" },
				city: { required: "Enter City" },
				prov: { required: "Enter Province" }
			}
		,
			errorPlacement: function (error, element) {
				error.appendTo(element.parent("td"));
			}

		});


	});


</script>


<!--slider script-->

<script>
	$(document).ready(function () {
		//Code goes here
		//Show the paging and activate its first link
		$(".paging3").show();
		$(".paging3 a:first").addClass("active");

		//Get size of the image, how many images there are, then determin the size of the image reel.
		var imageWidth = $(".window2").width();
		var imageSum = $(".image_reel img").size();
		var imageReelWidth = imageWidth * imageSum;

		//Adjust the image reel to its new size
		$(".image_reel").css({ 'width': imageReelWidth });

		//Paging  and Slider Function
		rotate = function () {
			var triggerID = $active.attr("rel") - 1; //Get number of times to slide
			var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide

			$(".paging3 a").removeClass('active'); //Remove all active class
			$active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

			//Slider Animation
			$(".image_reel").animate({
				left: -image_reelPosition
			}, 500);

		};

		//Rotation  and Timing Event
		rotateSwitch = function () {
			play = setInterval(function () { //Set timer - this will repeat itself every 7 seconds
				$active = $('.paging3 a.active').next(); //Move to the next paging
				if ($active.length === 0) { //If paging reaches the end...
					$active = $('.paging3 a:first'); //go back to first

				}
				rotate(); //Trigger the paging and slider function
			}, 5000); //Timer speed in milliseconds (5 seconds)
		};

		rotateSwitch(); //Run function on launch

		//On Hover
		$(".image_reel a").hover(function () {
			clearInterval(play); //Stop the rotation
		}, function () {
			rotateSwitch(); //Resume rotation timer
		});

		//On Click
		$(".paging3 a").click(function () {
			$active = $(this); //Activate the clicked paging
			//Reset Timer
			clearInterval(play); //Stop the rotation
			rotate(); //Trigger rotation immediately
			rotateSwitch(); // Resume rotation timer
			return false; //Prevent browser jump to link anchor
		});

	});
	function MM_swapImgRestore() { //v3.0
		var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
	}
	function MM_preloadImages() { //v3.0
		var d = document; if (d.images) {
			if (!d.MM_p) d.MM_p = new Array();
			var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
				if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
		}
	}

	function MM_findObj(n, d) { //v4.01
		var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById) x = d.getElementById(n); return x;
	}

	function MM_swapImage() { //v3.0
		var i, j = 0, x, a = MM_swapImage.arguments; document.MM_sr = new Array; for (i = 0; i < (a.length - 2); i += 3)
			if ((x = MM_findObj(a[i])) != null) { document.MM_sr[j++] = x; if (!x.oSrc) x.oSrc = x.src; x.src = a[i + 2]; }
	}
</script>

<style type="text/css">
<!--


/*--END Main Container for scrolling images--*/


-->
</style>

<script type="text/javascript">
var url = 'http://motiliti.net/LiveOnPageClient.ashx?ci=8479&pi=iddm_duo_tellus';var tt= new Date().getTime();document.write('<sc'+'ript type="text/javascript" ');document.write('src="'+url+'&t'+tt+'='+tt+'">');document.write('</sc'+'ript>');
</script>


<link href="Style.css" rel="stylesheet" type="text/css" />
<link rel="icon" 
      type="image/png" 
      href="images/favicon.png" />
<link href='http://fonts.googleapis.com/css?family=Monda:700' rel='stylesheet' type='text/css'></head>


<body id="bodyGurl">
   <form runat='server' id="form1" name='form1' method='POST' action="">
<div id="container">

<div id="crashBackground">

<div id="header"> <img src="http://images.waysideco.ca/1616/header_dynamic.png" width="1000" height="285" alt="Introducing The Dynamic Duo"/>
</div>



<div id="page1next">
<input type="image" src="http://images.waysideco.ca/1616/button_scratch.png" alt="Next - Scratch n Match"  />

</div>

<div id="whiteformbox"></div> 

<div id="informationTable">


<span style="font-weight: bold;font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">First Name:</span>
<input id="first" name="first" size="4" class="required" minlength="2" type="text" value="" placeholder="First Name" style="width:180px;color:#000;background: url(images/icon_pencil.png); background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; font-size: 13px; padding-left: 25px;"  />
<span style="font-weight: bold;font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">Last Name:</span><br/>
<input name="last" type="text" value=""  class="required" id="last" placeholder="Last Name" style="width:180px;color:#000;background: url(images/icon_pencil.png); background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; font-size: 13px; padding-left: 25px;"  size="4" minlength="2" />

</div>

<div id="contactTable">
<span style="font-weight: bold; font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">Email Address:</span>

<input id="email" name="email" placeholder="Email Address" value="" type="text"  size="22" class="required email" minlength="2" style="width:200px;color:#000; margin-top:5px; background-image: url(images/icon_email.png);  background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; font-size: 13px; padding-left: 25px;"  />

<span style="font-weight: bold;font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">Phone Number:</span><br/>
<input id="phonearea" name="phonearea" value="" placeholder="###" type="text" maxlength="3" size="3" style="width:30px;color:#000;background-image: url(images/icon_phone.png); background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; padding-left: 25px;"   /> 
<input placeholder="###" value="" type="text" id="phoneprefix" name="phoneprefix" maxlength="3" size="3" style="width:30px;color:#000; background: none; background-repeat:repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000;"   /> 
<input placeholder="####" type="text"  id="phonesuffix" name="phonesuffix" maxlength="4" size="5" style="width:40px;color:#000;background: none; background-repeat:repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000;"   /><br/>

</div>

<div id="addressTable">

  <span style="font-weight: bold; font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">Address:</span>

  
  <input id="addr1" name="addr1"  placeholder="Street Address" type="text"  size="24" class="required" 
		minlength="2" 
		style="width:200px;color:#000; background-image: url(images/icon_address.png); background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; padding-left: 25px;"   />
  <span style="font-weight: bold; font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">City:</span>

<input id="city" name="city"  placeholder="City" type="text"  size="24" class="required " 
		minlength="2" 
		style="width:100px;color:#000;  background-image: url(images/icon_city.png); background-repeat:no-repeat; border-top: none; border-left: none; border-right: none; border-bottom: 1px dashed #000; padding-left: 25px;"   />

    <span style="font-weight: bold; margin-top: -5px; font-family: 'Monda', sans-serif; font-size: 14px; text-transform: uppercase;">Province:</span>

  <select name="prov" id="prov" class="required" style=" border: 1px dashed #000; width: 150px;" >
  <option value="">Select your province</option>
  <option>Alberta</option>
  <option>British Columbia</option>
  <option>Manitoba</option>
  <option>New Brunswick</option>
  <option>Newfoundland and Labrador</option>
  <option>Nova Scotia</option>
  <option>Northwest Territories</option>
  <option>Nunavut</option>
  <option>Ontario</option>
  <option>Prince Edward Island</option>
  <option>Quebec</option>
  <option>Saskatchewan</option>
  <option>Yukon Territory</option>
  </select>
  <br/>
</div>

</div>



 



<div id="footer">
     <div style="margin: 0 auto; clear: both; width:1000px;border-width:0px;text-align:center; padding-top:280px;"><span style="font-size:10px;line-height:normal;color:#FFF;font-weight:normal"><A href="disclaimer.aspx" target="_blank" style="color:#FFF">Rules and Regulations</A>  Present the validated offers at <%#campaign.GetIt("DealerFriendlyName")%>, located at</span><br />

<span style="font-size:13px;line-height:24px;color:#FFF;font-weight:normal;"><span style="font-size:14px;line-height:normal;color:#FFF;font-weight:bold;"><%#campaign.GetIt("DealerFriendlyName")%></span> <%#campaign.GetIt("Addr1")%> <%#campaign.GetIt("Addr2")%>&nbsp;&nbsp;<%#campaign.GetIt("City")%> <%#campaign.GetIt("StateOrProvince")%> <%#campaign.GetIt("PostalCode")%>&nbsp;&nbsp;|&nbsp;&nbsp;<%#campaign.GetIt("PhoneNumber")%>&nbsp;&nbsp;<%#campaign.GetIt("TollFreeNumber")%></span>
</div></div>
<div id="footer_disclaimer" style="font-size:11px; color:#FFF; margin: 0 auto;">*All offers subject to change without notice. All offers not available at all locations. Please see dealer to confirm offers and availability.</div>
</div>
<input type="hidden" name="Lat" id="Lat" value="" runat="server" />
<input type="hidden" name="Lon" id="Lon" value="" runat="server" />
<input type="hidden" name="PC" id="PC" value="" runat="server" />
<input type="hidden" name="Source" id="Source" value="Mail" runat="server" />
<input type="hidden" name="IsLead" value="True" />
<input type="hidden" name="Survey10" id="Survey10" runat="server"  />
<input type="hidden" name="Survey11" id="Survey11" runat="server"  />
<input type="hidden" name="SenderRID" id="SenderRID" runat="server"  />
<input type="hidden" name="ReferrerID" id="ReferrerID" runat="server"  />
<input type="hidden" name="SalesRep" id="SalesRep" value="" runat="server" />
<input type="hidden" name="HasCompletedForm" value="True" />
<input type="hidden" id="__ErrorMessage" value="" runat="server" />
</form>

</body>
</html>
