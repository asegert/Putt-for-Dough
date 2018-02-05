<%@ Page Language="C#" ContentType="text/html" %>

<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2016
*/--%>
<script runat="server" language="c#">
		
    AutoGrossCampaign.Campaign campaign;
    AutoGrossCampaign.Responder responder;

    public int CampaignId;
		public string Source = "Mail";

    protected void Page_Init(Object Src, EventArgs E)
    {

        // Initialize campaign object to pull campaign data into the page with GetIt
        if (int.TryParse(ConfigurationManager.AppSettings["CampaignId"], out CampaignId)) campaign = new AutoGrossCampaign.Campaign(CampaignId); else campaign = new AutoGrossCampaign.Campaign();

        // Bind the page
        Page.DataBind();
    }

		protected void Page_Load(Object Src, EventArgs E)
		{

			if (Page.IsPostBack)		// Attempt update only on postback if we have valid recipient
			{

				string pin = Request.Form["PinCode"].ToString();
				
				string URLString = "game.aspx?S=" + Source + "&PIN=" + pin;
				Response.Redirect(URLString);

			}
		}
		
</script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex" />
    <title>Cashino | Sales Event</title>
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
    <link href="css/dos_landing.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.bxslider.min.js"></script>
    <link href="scripts/jquery.bxslider.css" rel="stylesheet" type="text/css" />
    <script src="scripts/TweenMax.min.js"></script>
    <script src="scripts/vendor/jquery.validate.min.js"></script>
 

    <script type="text/javascript" src="scripts/mdetect.js"></script>

    <script type="text/javascript">

      

</script>

  
    <script type="text/javascript">
    	var time = null
    	var mobileHomePage = 'gurl_mobile.aspx';

    	if (isTierIphone || DetectMobileQuick()) {
    		window.location = mobileHomePage;
    	}
    </script>

    <style>
        html, body {
            overflow-x:hidden;
            background-color:#000;
        }
    </style>

</head>    	
<%#campaign.GetIt("Script1")%>

<body class="cityscape">

<img id="supeman-panel" src="http://images.waysideco.ca/dos2016/superman_panel.png" />
<img id="batman-panel" src="http://images.waysideco.ca/dos2016/bat_panel.png" />

<audio autoplay>
  <source src="sounds/cashino.mp3" type="audio/mpeg">
</audio>
<audio autoplay loop>
  <source src="sounds/slots.mp3" type="audio/mpeg">
</audio>



<div class="container" style="z-index:10000;">
        <div class="row">
            <div class="col-xs-12">
                <h1 id="presents" class="mont text-center"><%#campaign.GetIt("DealerFriendlyName")%> PRESENTS</h1>
            </div>
        </div>
        <div class="row">
                <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">          
                        <img id="logo" src="http://images.waysideco.ca/dos2016/dos_logo.png" style="width:100%;height:auto;">       
                </div>
        </div>

      
        <div class="row">
                <div id="sign-up-box" class="col-xs-12 col-md-6 col-md-offset-3">
                  
                        <div class="row">
                                <div class="col-xs-12">
                                        <div class="row">
                                                <div class="col-xs-12">
                                                        <h4 class="text-center source-bold" id="enterPostal" style="color:#FFFFFF;">ENTER YOUR <br class="visible-xs-inline" />SECRET CODE BELOW:</h4>
                                                </div>
                                               
                                        </div>
                                        <div class="row">
                                            <form id="form1" runat='server' name='form1' method='POST' action="" class="form-inline">
                                                <div class="input-group col-xs-8 col-xs-offset-2 col-md-6 col-md-offset-3">
                                                        <input id="pincode" name="pincode" class="pincode required pincode form-control input-lg source-bold" maxlength="6" placeholder="#"/>
                                                        <span class="input-group-btn">
                                                                <button type="submit" class="btn btn-lg btn-primary title">
                                                                        <span class="source-bold" style="color: #FFF;">ENTER</span>
                                                                </button>
                                                        </span>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="row">
                                                <div class="col-xs-12 text-center kelly error-box" >

                                                </div>
                                        </div>
                                        <div class="row">
                                                    <div class="col-xs-12">
                                                        <h5 id="code-gen-headline" class="source text-center">
                                                            NEED A SECRET CODE? CLICK THIS BUTTON TO GENERATE ONE! &nbsp; &nbsp;
                                                            <button onClick="randomNumber();" class="btn-sm btn-danger source-bold" style="margin-top:5px; font-size:14px;display:inline-block;">GENERATE MY CODE</button>
                                                        </h5>
                                                    </div>
                                        </div>

                                 </div>
                        </div>                  
                </div>
        </div>
 
</div>

<div class="container-fluid">
    <div class="row">
        <ul class="bxslider">
                <li><img src="http://images.waysideco.ca/dos2016/dos_slide1.png" style="width:100%;height:auto;"/></li>
                <li><img src="http://images.waysideco.ca/dos2016/dos_slide1.png" style="width:100%;height:auto;"/></li>
                <li><img src="http://images.waysideco.ca/dos2016/dos_slide1.png" style="width:100%;height:auto;"/></li>
            </ul>
    </div>     
</div>



<div class="container-fluid" id="footer">
    <div class="row" style="padding-bottom:10px;">
                        <div class="col-xs-12">
                             <footer> 
                                    <p class="text-center kelly" style="color:#FFFFFF;margin-top:30px;padding-bottom:25px;margin-bottom:0px; font-size:20px;text-shadow: 0px 0px 1px #000, 0px 0px 3px #000; ">*All offers subject to change without notice. All offers not available at all locations.
                                        Please see dealer to confirm offers and availability. <br>IDDM &copy; 2016</p>
                            </footer>
                        </div>
    </div>
</div>
                        


    
    <script src="scripts/bootstrap.min.js"></script>
    
    <script>
	

                $(document).ready(function () {
                    $('.bxslider').bxSlider({ auto: true, pager: false, options:'fade'});

                      //detect ie8 and thro modal
                        if(navigator.appName.indexOf("Internet Explorer")!=-1){     //yeah, he's using IE
                            var badBrowser=(
                                navigator.appVersion.indexOf("MSIE 9")==-1 &&   //v9 is ok
                                navigator.appVersion.indexOf("MSIE 1")==-1  //v10, 11, 12, etc. is fine too
                            );

                            if(badBrowser){
                                $('#ieModal').modal('show')
                            }
                        }




                });    
                var codeh = 0;


            var logo = document.getElementById("logo"),
                signUp = document.getElementById("sign-up-box"),
                slider = document.getElementById("slider"),
                footie = document.getElementById("footer"),
				
                cash = document.getElementsByClassName("cash"),
                intro = document.getElementsByClassName("intro"),
                tl = new TimelineMax({delay:0.75}),
                arrow = document.getElementById("arrow"),
                prize = document.getElementById("prize-pulse"),
                tlTwo = new TimelineMax({repeat:-1});

             
  


                    tl.set(cash, {transformOrigin:"50% bottom"});
                    tlTwo.set(arrow, {transformOrigin:"top 50%"});

              
                  tl.to(logo, 0.0, {scale:1, opacity:1, zIndex:"10000"})
                    .staggerTo(intro, .5, {scale:1, opacity:1}, 0.1)
                    .to(cash, 0.0, {opacity:1, scale:1})
                    .to(signUp, 1, {scale:1, top:0, opacity:1,  ease: Sine.easeInOut}, 0.5)
                    .fromTo( prize, 0.75, {scale:1, textShadow:'0px 0px 25px rgba(255, 255, 255, 0.95),0px 0px 1px rgba(255, 255, 255, 0.95)', ease:Power1.easeInOut}, {scale:1.1,  textShadow:'0px 0px 30px rgba(255, 255, 255, 0.95), 0px 0px 15px rgba(255, 255, 255, 0.95),', repeat:-1, yoyo:true}, 1);
                  tl.to(slider, 0.3, {top:0, opacity:1,  ease: Sine.easeInOut}, 0.75)
                    .to(footie, 0.5, {scale:1, top:0, opacity:1,  ease: Sine.easeInOut}, 0.25);
                tlTwo.to(arrow, 1, {position:"absolute", y:"-20px", opacity:0});
                
                




                      $(document).ready(function () {

            $('#form1').validate({
                messages: {
                    pincode: { required: "Please Enter a Valid Secret Code",
                        digits: "Enter Number"
                    }
                }
        ,
                errorPlacement: function (error, element) {
                    error.appendTo($('.error-box'));
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

        $('.pincode').val(randomstring);
        return true;

        }
            


    </script>
   

</body>
</html>