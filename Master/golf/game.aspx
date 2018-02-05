<%@ Page Language="C#" ContentType="text/html" %>


<%--/* Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2016
*/--%>

<script runat="server" language="c#">

		// ********************************* START RESPONDER INITIALIZATION CODE - EXISTING RESPONDER ********************************* //

/*		AutoGrossCampaign.Campaign campaign;

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

		string URLString = "game.aspx?S=" + source + "&PIN=" + pin + "&Rep=" + rep;
		Response.Redirect(URLString);


	}


}*/

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

		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	    <link rel="stylesheet" type="text/css" href="css/golf.css">
        <link href='https://fonts.googleapis.com/css?family=Passion+One:400,900|Pathway+Gothic+One' rel='stylesheet' type='text/css'>
        <script src="scripts/vendor/modernizr-2.8.3.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/vendor/TweenMax.min.js"></script>
        <script type="text/javascript" src="scripts/SplitText.min.js"></script>

        <script src="src/phaser-arcade-physics.2.4.6.min.js"></script>
	    <script src="src/storage.js"></script>
	    <script src="src/Boot.js"></script>
	    <script src="src/Preloader.js"></script>
	    <script src="src/MainMenu.js"></script>
	    <script src="src/Achievements.js"></script>
	    <script src="src/Story.js"></script>
	    <script src="src/Game.js"></script>
        <script src="src/GameTwo.js"></script>
        <script src="src/GameThree.js"></script>

        <script src="scripts/bootstrap.min.js"></script>

    <style>

     body{margin:0;padding:0;background:#000;}

    .passion{
        font-family: 'Passion One', sans-serif;
        font-weight:400;
    }

    .passion-bold{
        font-family: 'Passion One', sans-serif;
        font-weight:700;
        letter-spacing: 1px;
    }

    .passion-heavy{
        font-family: 'Passion One', sans-serif;
        font-weight:900;
    }

    .goth {
        font-family: 'Pathway Gothic One', sans-serif;
    }

    #font-loader {
        position: absolute;top:-5000;left:-5000px;
        font-family: 'Passion One', sans-serif;
        font-weight:700;
        letter-spacing: 1px;
    }

    </style>
    <%//#campaign.GetIt("Script2")%>

</head>

<body>

<h1 id="font-loader">test</h1>

<form runat='server' id="form1" name='form1' method='POST' action="">


    <!-- Modal -->
    <div class="modal fade" id="instructions" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                <h1 class="text-center passion-bold">INSTRUCTIONS</h1>
                                <img src="http://images.waysideco.ca/putt4dough2016/hole1_instructions.png" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                             <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <div class="row">
                                    <div class="col-xs-6">

										<img src="images/shot.jpg" style="width:100%;height:auto;"/>
									<!--
                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/golf.mp4" type="video/mp4">
                                            <source src="video/golf.ogv" type="video/ogv">
                                            Your browser does not support the video tag.

                                        </video> -->
                                    </div>
                                    <div class="col-xs-6">
                                        <img src="images/hole1.jpg" style="width:100%;height:auto;"/>
										<!--
                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/Hole1.mp4" type="video/mp4">
                                            <source src="video/Hole1.ogv" type="video/ogv">
                                            Your browser does not support the video tag.

                                        </video> -->
                                    </div>
                                  </div>
                              </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/skip_inst.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/hole1_hint.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-lg btn-block btn-danger passion" data-dismiss="modal">PLAY NOW</button>
                            </div>
                        </div>
   <p class="text-center goth" style="color:#000;">
                        <a href="disclaimer.aspx" target="_blank" style="color: #000;" class="passion">Rules and Regulations</a><br />
                        *All offers subject to change without notice. All offers not available at all locations.
                        Please see dealer to confirm offers and availability.
                        <br>
                        IDDM &copy; 2016
                    </p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="winOne" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-6 col-xs-offset-3 col-sm-4 col-sm-offset-4">
                                <img src="images/congrats_ball.png" style="width: 100%; height: auto;" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <h3 id="discout-phrase-one" class="text-center goth">You've won an instant win prize of up to a $100 Service Credit!*</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <img id="coupon-one" src="http://images.waysideco.ca/putt4dough2016/p4d_prize100.jpg" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <p class="text-center">
                                   <button type="button"  onclick="holeTwo()" class="next-btn btn btn-lg btn-danger passion">PLAY NEXT HOLE</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <!-- Modal -->
    <div class="modal fade" id="instructions-two" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                <h1 class="text-center passion-bold">INSTRUCTIONS</h1>
                                <img src="http://images.waysideco.ca/putt4dough2016/hole1_instructions.png" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                             <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <div class="row">
                                    <div class="col-xs-6">
                                        	<img src="images/shot.jpg" style="width:100%;height:auto;"/>
																		<!--
                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/golf.mp4" type="video/mp4">
                                            <source src="video/golf.ogv" type="video/ogv">
                                            Your browser does not support the video tag.

                                        </video> -->
                                    </div>
                                    <div class="col-xs-6">

                                        	<img src="images/hole2.jpg" style="width:100%;height:auto;"/>
																		<!--

                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/Hole2.mp4" type="video/mp4">
                                            <source src="video/Hole2.ogv" type="video/ogv">
                                            Your browser does not support the video tag.

                                        </video> -->
                                    </div>
                                  </div>
                              </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/skip_inst.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/hole2_hint.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-lg btn-block btn-danger passion" data-dismiss="modal">PUTT</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <!-- Modal -->
    <div class="modal fade" id="winTwo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-6 col-xs-offset-3 col-sm-2 col-sm-offset-5">
                                <img src="images/congrats_ball.png" style="width: 100%; height: auto;" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <h3 id="discout-phrase-two" class="text-center goth">You've won an instant win prize of up to $500 in Accessories!*</h3>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <img id="coupon-two" src="http://images.waysideco.ca/putt4dough2016/p4d_prize500.png" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <p class="text-center">
                                   <button type="button"  onclick="holeThree()"  class="next-btn btn btn-lg btn-danger passion">PLAY NEXT HOLE</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <!-- Modal -->
    <div class="modal fade" id="instructions-three" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                <h1 class="text-center passion-bold">INSTRUCTIONS</h1>
                                <img src="http://images.waysideco.ca/putt4dough2016/hole1_instructions.png" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                             <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <div class="row">
                                    <div class="col-xs-6">
                                        <img src="images/shot.jpg" style="width:100%;height:auto;"/>
																		<!--
                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/golf.mp4" type="video/mp4">
                                            <source src="video/golf.ogv" type="video/ogv">
                                            Your browser does not support the video tag.

                                        </video> -->
                                    </div>
                                    <div class="col-xs-6">
										<img src="images/hole3.jpg" style="width:100%;height:auto;"/>
										<!--
                                        <video id="golf-instructions-vid" width="100%" height="auto" autoplay loop>
                                            <source src="video/Hole3.mp4" type="video/mp4">
                                            <source src="video/Hole3.ogv" type="video/ogv">
                                            Your browser does not support the video tag.
                                        </video> -->
                                    </div>
                                  </div>
                              </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/skip_inst.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                         <div class="row">
                             <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                                 <img src="http://images.waysideco.ca/putt4dough2016/hole3_hint.png" style="width:100%;height:auto;"/>
                             </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-lg btn-block btn-danger passion" data-dismiss="modal">PUTT</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="winThree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
        <div class="modal-dialog-lg" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="burstBox">
                        <div class="row">
                            <div class="col-xs-6 col-xs-offset-3 col-sm-2 col-sm-offset-5">
                                <img src="images/congrats_ball.png" style="width: 100%; height: auto;" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <h3 id="discout-phrase-three" class="text-center goth">Your final score of <span id="final-score" style="font-weight:bold;">0</span> has unlocked an instant win prize of up to a $1,000 Trade Bonus!*</h3>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <img id="coupon-three" src="http://images.waysideco.ca/putt4dough2016/p4d_prize1000.png" style="width:100%;height:auto;"/>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-xs-10 col-xs-offset-1 col-md-6 col-md-offset-3">
                                <p class="text-center">
                                   <button type="submit" class="next-btn btn btn-lg btn-danger passion">COLLECT YOUR PRIZES!</button>
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

    <script src="src/start.js"></script>


    <script>
        EPT.Strokes = null;

        function holeTwo() {
            $('#winOne').modal('hide');
            $('#instructions-two').modal('show');
            resetThings();
        }

        function holeThree() {
            $('#winTwo').modal('hide');
            $('#instructions-three').modal('show');
            resetThings();
        }

        var congratsOne = document.getElementById('congratsOne'),
        burstBox = document.getElementsByClassName('burstBox'),
        discountOneSplit = document.getElementById("discout-phrase-one"),
        discountTwoSplit = document.getElementById("discout-phrase-two"),
        discountThreeSplit = document.getElementById("discout-phrase-three"),
        coupOne = document.getElementById("coupon-one"),
        coupTwo = document.getElementById("coupon-two"),
        coupThree = document.getElementById("coupon-three"),
        nextBtn = document.getElementsByClassName('next-btn');

        var h = window.innerHeight;
        $(".burstBox").height(h);

        $(window).resize(function () {
            var h = window.innerHeight;
            $(".burstBox").height(h);
        });

        tl = new TimelineMax();
        tl.set(burstBox, { height: h });

        tl.set([discountOneSplit, discountTwoSplit, discountThreeSplit], { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 });
        tl.set([coupOne, coupTwo, coupThree], { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 });
        tl.set(nextBtn, { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 })

        function resetThings() {
            tl.set([coupOne, coupTwo, coupThree], { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 });
            tl.set(nextBtn, { transformStyle: "preserve-3d", transformOrigin: "50% 50%", scale: 0.05, opacity: 0 })
        }

        //hook in to modal 1 show Event
        $("#winOne").on('show.bs.modal', function (e) {
            //  tl.to(couphundy, 1, { rotation: 1440, opacity: 1, scale: 1, delay: 0.25, ease: Power2.easeIn, delay: 0.25 })
            tl.to(discountOneSplit, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
              .to(coupOne, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
            //.staggerTo(discountOneSplit, 0.5, { opacity: 1 }, 0.02)
            .to(nextBtn, 1, { scale: 1, opacity: 1, ease: Elastic.easeOut.config(0.9, 0.3) })
        });

        //hook in to modal 2 show Event
        $("#winTwo").on('show.bs.modal', function (e) {
            //  tl.to(couphundy, 1, { rotation: 1440, opacity: 1, scale: 1, delay: 0.25, ease: Power2.easeIn, delay: 0.25 })
            tl.to(discountTwoSplit, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
                 .to(coupTwo, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
            //.staggerTo(discountOneSplit, 0.5, { opacity: 1 }, 0.02)
            .to(nextBtn, 1, { scale: 1, opacity: 1, ease: Elastic.easeOut.config(0.9, 0.3) })
        });

        //hook in to modal 3 show Event
        $("#winThree").on('show.bs.modal', function (e) {
            //  tl.to(couphundy, 1, { rotation: 1440, opacity: 1, scale: 1, delay: 0.25, ease: Power2.easeIn, delay: 0.25 })
            tl.to(discountThreeSplit, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
              .to(coupThree, 0.75, { opacity: 1, scale: 1, ease: Elastic.easeOut.config(0.9, 0.3) }, 1.25)
            //.staggerTo(discountOneSplit, 0.5, { opacity: 1 }, 0.02)
            .to(nextBtn, 1, { scale: 1, opacity: 1, ease: Elastic.easeOut.config(0.9, 0.3) })
        });



        $(document).ready(function () {
            /* Get iframe src attribute value i.e. YouTube video url
            and store it in a variable */
            var url = $("#golf-instructions-vid").attr('src');

            /* Assign empty url value to the iframe src attribute when
            modal hide, which stop the video playing */
            $("#myModal").on('hide.bs.modal', function () {
                $("#cartoonVideo").attr('src', '');
            });

            /* Assign the initially stored url back to the iframe src
            attribute when modal is displayed again */
            $("#myModal").on('show.bs.modal', function () {
                $("#cartoonVideo").attr('src', url);
            });
        });

        $(document).ready(function () {
            $('#instructions').modal('show');
        });



    </script>


</body>
</html>
