EPT.Gametwo = function(game) {};
EPT.Gametwo.prototype = {
	create: function() {
	    this._score = EPT.Strokes;
	//	this._time = 10;
		this.gamePaused = false;
		this.runOnce = false;
        this.ballMoving = false;
		this.playing = true;
		this.balldrag = 0;
        this.inWater = false;
		
		//audio
		this.inCup = this.add.audio('cup');
		this.putt = this.add.audio('putt');
		this.cheer = this.add.audio('cheer');
        this.splashSound = this.add.audio('splash');
		
        /*
		this.currentTimer = game.time.create();
		this.currentTimer.loop(Phaser.Timer.SECOND, function() {
			this._time--;
			if(this._time) {
				this.textTime.setText('Time left: '+this._time);
			}
			else {
				this.stateStatus = 'gameover';
			}
		}, this);
		this.currentTimer.start(); */
        
        //start building the game
        
        
		
        //set world bounds and start up the physics
		this.game.world.setBounds(0, 0, 960, 640);
        this.physics.startSystem(Phaser.Physics.ARCADE);
    
        this.grass = this.add.sprite(0, 0, 'grass-two');
        
        this.hole = this.add.sprite(750, 150, 'hole');
        this.hole.anchor.x = 0.5;
        this.hole.anchor.y = 0.5;
        this.game.physics.arcade.enable(this.hole);
        
        //for checking alignment of ball/hole
       // this.reddot = this.add.sprite(this.hole.x, this.hole.y, 'reddot');
       // this.reddot.anchor.x = 0.5;
       // this.reddot.anchor.y = 0.5;
        
        this.rock = this.add.sprite(this.world.width/2, 449, 'rock-long');
		this.rock.anchor.x = 0.5;
        this.rock.anchor.y = 0.5;
        this.game.physics.enable(this.rock, Phaser.Physics.ARCADE);
        this.rock.body.collideWorldBounds = true;
        this.rock.body.immovable = true;
        
        
        this.rocksmall = this.add.sprite(655, this.world.height/2-25, 'rocksmall');
		this.rocksmall.anchor.x = 0.5;
        this.rocksmall.anchor.y = 0.5;
        this.game.physics.enable(this.rocksmall, Phaser.Physics.ARCADE);
        this.rocksmall.body.collideWorldBounds = true;
        this.rocksmall.body.immovable = true;
        
		//create a ball
        this.ball = this.add.sprite(100, 100, 'ball');
		this.ball.anchor.x = 0.5;
        this.ball.anchor.y = 0.5;
		this.game.physics.enable(this.ball, Phaser.Physics.ARCADE);
        this.ball.body.collideWorldBounds = true;
        this.ball.body.bounce.setTo(1, 1);
		//the ball slows down by itself at this rate
		
       // this.ball.linearDamping = 20;
        
		//this.ball.body.setCircle(12, 12, 12);
  		//this.ball.body.damping = 0.6;
		//used to check if the ball has come to a hold
  		this.ball.body.drag.setTo(this.balldrag, this.balldrag);
        //this.ball.body.drag.y = 40;
        
		//variable for sprite that holds the arrow, but we don't need it right away
  		this.arrow = null;
		
		//flag to check if mousekey is down (or if finger is touching down on mobile)
  		this.inputPressed = false;
		
		//setting up a callback, so that the function inputDown is called every time the screen is touched/the mouse is pressed
  		this.game.input.onDown.add(this.inputDown, this);
  		//call inputUp every time the mouse button is let go / the finger is lifted
  		this.game.input.onUp.add(this.inputUp, this);
		
		this.downTime;
		this.mode = -1;
		this.setMode(0);
		this.power = null;
		this.initUI();
		//this.createArrow();
		
		//  test arrow
		//  create the direction arrow
		//  this.testarrow = game.add.sprite(0, 0, 'arrow');
		//  this.testarrow.anchor.setTo(0.5, 0.5);
		//  this.testarrow.pivot.x = 0;
		//  this.testarrow.pivot.y = +35;
		//  add it as a child to the ball, so that it circles the ball
		//  this.ball.addChild(this.testarrow);
        
	},
	
	onSand: function(){
		console.log("on sand");
		this.ball.body.drag.setTo(550, 550);
	},
	
	inputDown: function(pointer) {
		console.log("input down");
  		this.inputPressed = true;
	},

	inputUp: function(pointer) {
		console.log("input up");
  		this.inputPressed = false;
	},
	
	//adds the arrow to the game (called when the ball is laying still and the player can make his move)
	createArrow: function() {
		console.log("createArrow function called");
	  //create the direction arrow
	  this.arrow = game.add.sprite(0, 0, 'arrow');
	  this.arrow.anchor.setTo(0.5, 0.5);
	  this.arrow.pivot.x = 0;
	  this.arrow.pivot.y = +35;
	  //add it as a child to the ball, so that it circles the ball
	  this.ball.addChild(this.arrow);
	},
	
	//removes the arrow from the game
	removeArrow: function() {
  		this.ball.removeChild(this.arrow);
  		this.arrow.destroy();
	},
	
	//set the mode variable and create / destroy the arrow depending on the mode
	//mode 1 means the ball is moving
	//mode 2 means the ball is laying stil
	setMode: function(newMode) {
		console.log(newMode);
	  	if (this.mode != newMode) {
		    //ball is moving
			if (this.mode === 1) {
			  this.removeArrow();
              this.ballMoving = true;
              console.log("bvall is moving");
			} else if (this.mode === 0) {
                this.ballMoving = true;
			     this.createArrow();
			  //make sure the ball does not move
			  this.ball.body.velocity.x = 0;
			  this.ball.body.velocity.y = 0;
			  this.ball.body.rotation = 0;	
			  this.downTime = 0;
			}
			this.mode = newMode;
			console.log("new mode is" + " " + this.mode);
	  	}
	},
	
	//calculate a number between 0 and 500 based on how long the mousebutton/finger is pressed
	//this number goes from 0 to 500 and then back down again to 0 and then starts over.
	powerUp: function() {
	  this.power = Math.abs(((game.time.time - this.downTime + 600) % 1000) -600);
	},

	skipLevel: function () {

	    if (EPT.Strokes <= 7) {
	        EPT.Strokes = 13;
	    } else if (EPT.Strokes >= 8) {
	        EPT.Strokes = EPT.Strokes + 5;
	    }

	    this.textScore.setText('Score: ' + EPT.Strokes);
	    if (this.playing) {
	        this.inCup.play();
	        this.cheer.play('', 0, 1, false);

	        this.time.events.add(Phaser.Timer.SECOND * 2.5, this.holeThree, this);
	        $('#winTwo').modal('show');

	        this.mode = 2;
	        this.ball.body.velocity.x = 0;
	        this.ball.body.velocity.y = 0;
	        this.add.tween(this.ball.position).to({ x: (this.hole.body.x + 18), y: (this.hole.body.y + 18) }, 50, Phaser.Easing.Linear.In, true, null); // nope 
	        this.add.tween(this.ball.scale).to({ x: 0.6, y: 0.6 }, 50, Phaser.Easing.Linear.In, true, null); // nope   
	    }
	},

	initUI: function() {
	

	    var fontScore = { font: "32px Passion One", fill: "#fff" };
	    var fontScoreWhite = { font: "32px Arial", fill: "#FFF" };
	    this.textScore = this.add.text(130, this.world.height - 10, 'Score: ' + EPT.Strokes, fontScore);
	    this.textScore.anchor.set(0, 1);

	    this.skip = this.add.button(10, this.world.height - 45, 'skip', this.skipLevel, this, 1, 0, 2);

        /*
		this.textTime = this.add.text(this.world.width-30, this.world.height-20, 'Time left: '+this._time, fontScore);
		this.textTime.anchor.set(1,1); */
        
		var fontTitle = { font: "48px Arial", fill: "#000", stroke: "#FFF", strokeThickness: 10 };

	
		//this.buttonAudio = this.add.button(this.world.width-20, 20, 'button-audio', this.clickAudio, this, 1, 0, 2);
		//this.buttonAudio.anchor.set(1,0);

		//this.buttonAudio.setFrames(EPT._audioOffset+1, EPT._audioOffset+0, EPT._audioOffset+2);

        /* game over overlay with play again button
		this.screenGameoverGroup = this.add.group();
		this.screenGameoverBg = this.add.sprite(0, 0, 'overlay');
		this.screenGameoverText = this.add.text(this.world.width*0.5, 100, 'Game over', fontTitle);
		this.screenGameoverText.anchor.set(0.5,0);
		this.screenGameoverBack = this.add.button(150, this.world.height-100, 'button-mainmenu', this.stateBack, this, 1, 0, 2);
		this.screenGameoverBack.anchor.set(0,1);
		this.screenGameoverRestart = this.add.button(this.world.width-150, this.world.height-100, 'button-restart', this.stateRestart, this, 1, 0, 2);
		this.screenGameoverRestart.anchor.set(1,1);
		this.screenGameoverScore = this.add.text(this.world.width*0.5, 300, 'Score: '+this._score, fontScoreWhite);
		this.screenGameoverScore.anchor.set(0.5,0.5);
		this.screenGameoverGroup.add(this.screenGameoverBg);
		this.screenGameoverGroup.add(this.screenGameoverText);
		this.screenGameoverGroup.add(this.screenGameoverBack);
		this.screenGameoverGroup.add(this.screenGameoverRestart);
		this.screenGameoverGroup.add(this.screenGameoverScore);
		this.screenGameoverGroup.visible = false; */
	},
    
    inHole: function(){
		if(this.playing){
			this.inCup.play();
			this.cheer.play('', 0, 1, false);
			this.time.events.add(Phaser.Timer.SECOND * 2.5, this.holeThree, this);
			setTimeout(function(){ 
				$('#winTwo').modal('show');
			}, 1500);
			
			this.mode = 2;
			this.ball.body.velocity.x = 0;
			this.ball.body.velocity.y = 0;
			this.add.tween(this.ball.position).to({ x: (this.hole.body.x+18), y: (this.hole.body.y+18) }, 50, Phaser.Easing.Linear.In, true, null); // nope 
			this.add.tween(this.ball.scale).to({ x: 0.6, y:0.6 }, 50, Phaser.Easing.Linear.In, true, null); // nope   
		}
    },

    holeThree: function () {
        this.state.start('Gamethree');
    },
	
	bottomSplash: function(){
        this.inWater = true;
        this.mode = 2;
        EPT.Strokes += 1;
        this.textScore.setText('Score: ' + EPT.Strokes);

        var slowdown = this.add.tween(this.ball.body.velocity).to({ x: 0, y: 0 }, 150, Phaser.Easing.Linear.In, true, null);
        this.ball.scale.x = 0.5;
        this.ball.scale.y = 0.5;
        
        slowdown.onComplete.add(this.makeSplash, this);
        
        //this.game.time.events.add(Phaser.Timer.SECOND * 0.25, this.relocateBall, this);  
	},
    
    makeSplash: function(){
        this.splashSound.play();
        this.ball.alpha = 0;
        var splashX = this.ball.body.position.x -25,
            splashY = this.ball.body.position.y -25;
    
        console.log(splashX + ", " + splashY );
        this.splash = this.add.sprite( splashX, splashY, 'splash');
        this.splash.anchor.setTo(0, 0);
		this.splash.animations.add('sploosh');
        this.splash.animations.play('sploosh', 60, false);
        this.splash.animations.currentAnim.onComplete.add(function () {	
        this.splash.destroy();
        }, this);
    this.relocateBall();
    },
    
    relocateBall: function(){
        this.ball.x = 100;
        this.ball.y = 100;
        this.ball.scale.x = 1;
        this.ball.scale.y = 1;
        var fadeInBall = this.add.tween(this.ball).to({ alpha:1 }, 250, Phaser.Easing.Linear.In, true, null);
        this.inWater = false;
        fadeInBall.onComplete.add(this.resetBall, this);
    },
    
    resetBall: function(){
         this.setMode(0);
    },
    
	update: function() {

		this.physics.arcade.collide(this.ball, this.rocksmall);
        this.physics.arcade.collide(this.ball, this.rock);
        
        //check if ball hit top pond
        if(
            this.ball.body.x >= 295 &&
            this.ball.body.x <= 658 &&
            this.ball.body.y <= 150 &&
            this.inWater == false
        ){
            //make ball splash
            this.bottomSplash();
        }
        
        //check if ball hit bottom pond
        if(
            this.ball.body.x >= 295 &&
            this.ball.body.x <= 658 &&
            this.ball.body.y >= 475 &&
            this.inWater == false
        ){
            //make ball splash
            this.bottomSplash();
        }
        
		if(this.ball.body.y <= 50 || this.ball.body.y >= 570 || this.ball.body.x >= 900){
			this.ball.body.drag.setTo(700, 700);
		} else {
			this.ball.body.drag.setTo(this.balldrag, this.balldrag);
		}
		
		this.game.physics.arcade.overlap(this.ball, this.sand, this.onSand, null, this);
		
		if(this.checkOverlap(this.ball, this.hole)){
				this.inHole();
				this.playing = false;
        }
        
        if(this.ballMoving === true){
            this.ball.body.velocity.x = (this.ball.body.velocity.x * 0.99);
            this.ball.body.velocity.y = (this.ball.body.velocity.y * 0.99);
        }

		//rotate the arrow according to mouse/finger position
		//this.arrow.rotation = game.math.angleBetween(this.ball.body.x, this.ball.body.y, this.game.input.x, this.game.input.y) + Math.PI/2;

		
		switch(this.stateStatus) {
			case 'gameover': {
				if(!this.runOnce) {
					this.stateGameover();
					this.runOnce = true;
				}
				break;
			}
			case 'playing': {
				this.statePlaying();
			}
			default: {
			}
		}
		
		
		//mode 0 means the ball is moving
		  if (this.mode == 0) {
			  
			//Check if the ball is moving so slow that we can make it stop completly and switch to swing-mode
			if (Math.abs(this.ball.body.velocity.x) < 20 && Math.abs(this.ball.body.velocity.y) < 20) {
			  this.setMode(1);
			}

		  } else if (this.mode == 1) {
			//mode 1 is the swing mode, the ball is laying still

			//rotate the arrow according to mouse/finger position
			this.arrow.rotation = this.game.math.angleBetween(this.ball.body.x, this.ball.body.y, this.game.input.x, this.game.input.y) + Math.PI/2;

			if (this.inputPressed) {
				  if (this.downTime == 0) {
					//input has just been pressed, note the time this happend
					this.downTime = this.game.time.time;
				  } else {
					this.powerUp();
					//scale the arrow lengh according ot the result of the power function (power 0-500) -> arrow size 1.0 to 3.0
					this.arrow.scale.y = 1.0 + this.power/500 * 2;
				  }
			} else if (this.downTime != 0) {
			  	//the mousebutton has been released (or the finger lifted) now get the ball moving
			  	var angle = this.arrow.rotation - (Math.PI / 2);
				this.ball.body.velocity.x = (this.power + 50) * Math.cos(angle);    
				this.ball.body.velocity.y = (this.power + 50) * Math.sin(angle);
				this.addStrokes();
				//this.ball.body.velocity.x = this.game.physics.accelerationFromRotation(this.arrow.rotation - Math.PI/2, this.power + 50);
			  	//and count it as a swing
			  	//swingCount++;
			  	//and switch to ball-moving-mode
				this.setMode(0);
			}
		  } else if (this.mode == 2){
              
          }
		
		
	},
    
    checkOverlap: function(spriteA, spriteB) {
		
        var boundsA = spriteA.getBounds();
        var boundsB = spriteB.getBounds();
        return Phaser.Rectangle.intersects(boundsA, boundsB);

        //if ( this.ball.body.x < (this.hole.body.x + 15)
        //    && this.ball.body.x > (this.hole.body.x - 15)
        //    && this.ball.body.y < (this.hole.body.y + 15)
        //    && this.ball.body.y > (this.hole.body.y - 15)
        //   ){
        //    return Phaser.Rectangle.intersects(boundsA, boundsB);
        // }   
    },
	
	statePlaying: function() {
		this.screenPausedGroup.visible = false;
		this.currentTimer.resume();
	},
	
	stateGameover: function() {
		this.screenGameoverGroup.visible = true;
		this.currentTimer.stop();
		this.screenGameoverScore.setText('Score: '+this._score);
		storageAPI.setHighscore('EPT-highscore',this._score);
	},
    
    
    //function to add points - use to add strokes(shots taken)
	addStrokes: function() {
		this.putt.play();
		EPT.Strokes += 1;
		this.textScore.setText('Score: '+EPT.Strokes);
		//var randX = this.rnd.integerInRange(200,this.world.width-200);
		//var randY = this.rnd.integerInRange(200,this.world.height-200);
		//var pointsAdded = this.add.text(randX, randY, '+10',
		//	{ font: "48px Arial", fill: "#000", stroke: "#FFF", strokeThickness: 10 });
		//pointsAdded.anchor.set(0.5, 0.5);
		//this.add.tween(pointsAdded).to({ alpha: 0, y: randY-50 }, 1000, Phaser.Easing.Linear.None, true);
	}, 
    
	clickAudio: function() {
		if(!EPT._audioStatus) {
			EPT._soundClick.play();
		}
		EPT._manageAudio('switch',this);
	}
};