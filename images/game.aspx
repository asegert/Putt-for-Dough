<%@ Page Language="C#" ContentType="text/html" %>


<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2016
*/--%>

<script runat="server" language="c#">
		
		// ********************************* START RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //

		AutoGrossCampaign.Campaign campaign;
		
		public int CampaignId;

		
		protected void Page_Init(Object Src, EventArgs E)
		{

				// Initialize campaign object to pull campaign data into the page with GetIt
		    if (int.TryParse(ConfigurationManager.AppSettings["CampaignId"], out CampaignId)) campaign = new AutoGrossCampaign.Campaign(CampaignId); else campaign = new AutoGrossCampaign.Campaign();

		
				// Bind the page
				Page.DataBind();
		}

		// ********************************* END RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //


protected void Page_Load(Object Src, EventArgs E)
{

	if (!Page.IsPostBack)
	{
		// Save all our data in the viewstate since we may be here for a while and the session might expire
		// or the the query string might get lost
		
		ViewState["S"] = Request.QueryString["S"] != null ? Request.QueryString["S"] : "";
		ViewState["PIN"] = Request.QueryString["PIN"] != null ? Request.QueryString["PIN"] : "";
		ViewState["Rep"] = Request.QueryString["Rep"] != null ? Request.QueryString["Rep"] : "";
		ViewState["RecipientID"] = Session["RecipientID"] != null ? Session["RecipientID"] : "";
		
	}
	else
	{
		// Dig up all the data and put it in the query string 
		string source = ViewState["S"] != null ? ViewState["S"].ToString() : "";
		string pin = ViewState["PIN"] != null ? ViewState["PIN"].ToString() : "";
		string rep = ViewState["Rep"] != null ? ViewState["Rep"].ToString() : "";
		Session["RecipientID"] = ViewState["RecipientID"] != "" ? ViewState["RecipientID"] : null;
		
		// We don't want this to be vulnerable to changing, so it goes into a session variable
		Session["Score"] = player_score.Value;
		
		string URLString = "page1.aspx?S=" + source + "&PIN=" + pin + "&Rep=" + rep;
		Response.Redirect(URLString);
				

	}
	
	
}

 
 
</script>



<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="mobile-web-app-capable" content="yes">

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
		<link href="css/dos_game.css" rel="stylesheet" type="text/css" />
      	<link href='https://fonts.googleapis.com/css?family=Fugaz+One' rel='stylesheet' type='text/css'/>
        <script src="scripts/vendor/modernizr-2.8.3.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/vendor/TweenMax.min.js"></script>
        <script type="text/javascript" src="scripts/SplitText.min.js"></script>

        <script src="src/phaser.min.js"></script>	
	    <script src="src/storage.js"></script>
	    <script src="src/Boot.js"></script>
	    <script src="src/Preloader.js"></script>
	    <script src="src/MainMenu.js"></script>
	    <script src="src/Achievements.js"></script>
	    <script src="src/Story.js"></script>
	    <script src="src/Game.js"></script>

         <script src="scripts/bootstrap.min.js"></script>

  <style>body{margin:0;padding:0;background:#000;}</style>

   <style>
       .modal-backdrop {
            background: url('images/burst_bg_sm.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
        /* Medium devices (desktops, 992px and up) */
    @media (min-width: 992px) {
        .modal-backdrop {
            background: url('images/burst_bg_lg.jpg') no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
    }
        .modal-header, modal-body, modal-footer {background: transparent;}
        .modal.fade .modal-dialog {
            -webkit-transform: translate(0, 0%);
            -ms-transform: translate(0, 0%);
            transform: translate(0, 0%);
            -webkit-transition: -webkit-transform 0.3s ease-out;
            -moz-transition: -moz-transform 0.3s ease-out;
            -o-transition: -o-transform 0.3s ease-out;
            transition: transform 0.3s ease-out;
        }
        .modal-content {background-color:transparent;border:none;}
        div.modal-content{
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            -o-box-shadow: none;
            box-shadow: none;
            height: 100%;
        }
        .modal-header{border-bottom:none;}
        .modal-footer{border-top:none;}

        body, html {
          background-color: black;
          height: 100%;
          margin:0;
          padding:0;
        }
        .modal-body {
            padding:0px;
        }

        .burstBox {
    padding-top:25%;
    width:100%;min-height:90%;
    background: url('images/starBurst.png') no-repeat center center fixed; 
      -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    }

    /* Small devices (tablets, 768px and up) */
    @media (min-width: 768px) {
        .burstBox{padding-top: 20%}
    }

    /* Medium devices (desktops, 992px and up) */
    @media (min-width: 992px) {
        .burstBox{padding-top: 15%}
    }

    /* Large devices (large desktops, 1200px and up) */
    @media (min-width: 1200px) {
        .burstBox{padding-top: 10%}
    }

    .modal-backdrop.in {
        opacity: 1;
    }

</style>
		
<%#campaign.GetIt("Script2")%>
</head>

<body>

<h1 id="font-loader">test</h1>

    
<form runat='server' id="form1" name='form1' method='POST' action="">


<!-- Modal -->
<div class="modal fade" id="winOne" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
  <div class="modal-dialog-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">
        	<div class="burstBox">
					
					<div class="row">
						<div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
							<h1 id="congratsOne" class="text-center headline fugaz" style="margin-top:0px;">CONGRATULATIONS</h1>
							<h3 id="discout-phrase-one" class="text-center fugaz">You have unlocked a $100 Gift Card from <%#campaign.GetIt("DealerFriendlyName")%></h3>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3 col-lg-4 col-lg-offset-4">
							<img id="hundy" src="http://images.waysideco.ca/cashino/gift100.jpg" style="width:100%;height:auto;"/>
						</div>
					</div>


					<div class="row">
						<div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
							<p class="text-center">
								<button type="submit" class="next-btn btn btn-lg btn-danger fugaz" style="min-width:30%;">SPIN AND WIN MORE!</button>
							</p>
						</div>
					</div>
			</div>
      </div>
    </div>
  </div>
</div>

	<input type="hidden" id="player_score" value="" runat="server" />
</form>


<script>
        $(document).ready(function () {
           $('#winOne').modal('show');
        });
    </script>	

<script src="src/TweenMax.min.js"></script>
<script src="src/start.js"></script>


    <script>
        var congratsOne = document.getElementById('congratsOne'),
	congratsTwo = document.getElementById('congratsTwo'),
	congratsThree = document.getElementById('congratsThree'),
	burstBox = document.getElementsByClassName('burstBox'),
	couphundy = document.getElementById('hundy'),
	//coupk = document.getElementById('thousand'),
	//coupTwok = document.getElementById('two-thousand'),
	winOneSplit = new SplitText("#discout-phrase-one", { type: "words,chars" }),
    discountOneSplit = winOneSplit.chars,
    //winTwoSplit = new SplitText("#discout-phrase-two", { type: "words,chars" }),
    //discountTwoSplit = winTwoSplit.chars,
   // winThreeSplit = new SplitText("#discout-phrase-three", { type: "words,chars" }),
   // discountThreeSplit = winThreeSplit.chars,
    nextBtn = document.getElementsByClassName('next-btn');




        var h = window.innerHeight;
        $(".burstBox").height(h);

        $(window).resize(function () {
            var h = window.innerHeight;
            $(".burstBox").height(h);
        });

        tl = new TimelineMax();
        tl.set(burstBox, { height: h });

        tl.set(couphundy, { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05 });
        tl.set([discountOneSplit], { transformStyle: "preserve-3d", opacity: 0 });
        tl.set(nextBtn, { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05 })

        //hook in to modal show Event
        $("#winOne").on('show.bs.modal', function (e) {
            tl.to(couphundy, 1, { rotation: 1440, opacity: 1, scale: 1, delay: 0.25, ease: Power2.easeIn, delay: 0.25 })
              .to(congratsOne, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) })
              .staggerTo(discountOneSplit, 0.5, { opacity: 1 }, 0.02)
              .to(nextBtn, 1, { scale: 1, opacity: 1, ease: Elastic.easeOut.config(0.9, 0.3) })
        });
        //on modal one closing
        $("#winOne").on('hide.bs.modal', function (e) {
            tl.set(nextBtn, { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 })
        });


      
    </script>
    

</body>
</html>