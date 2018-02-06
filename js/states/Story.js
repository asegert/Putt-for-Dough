var Golf = Golf || {};

Golf.StoryState = {
    create: function ()
    {
        //Main Background
        this.instruct = this.add.sprite(0, 0, 'main');
        //Start the music
        Golf.music = this.add.audio('background');
        Golf.music.play('', 0, 1, true);
        //Indicates wheher or not to move to second section of the main screen
        this.unclicked = true;
        //Sets the ball texture in case no 'ball' is selected
        Golf.ball = 'ball';
        //Creates the glow effect to show which ball is selected
        this.glow = this.add.sprite(0, 0, null);
        var style =
        {
            font: 'Arial',
            fontSize: 40,
            fill: '#FFFFFF'
        };
        //Sets up ball selection
        this.chooseText = this.add.text(10, 500, 'Choose your ball:', style);
        this.whiteBall = this.add.button(220, 550, 'ball', function ()
        {
            Golf.ball = 'ball';
            this.glow.destroy();
            this.glow = this.add.sprite(202, 532, 'glow');
            this.glow.scale.setTo(2.5, 2.5);
            this.world.bringToTop(this.whiteBall);
        }, this, 1, 0, 2);
        this.whiteBall.scale.setTo(2, 2);

        this.blackBall = this.add.button(290, 550, 'ballBlack', function ()
        {
            Golf.ball = 'ballBlack';
            this.glow.destroy();
            this.glow = this.add.sprite(272, 532, 'glow');
            this.glow.scale.setTo(2.5, 2.5);
            this.world.bringToTop(this.blackBall);
        }, this, 1, 0, 2);
        this.blackBall.scale.setTo(2, 2);

        this.blueBall = this.add.button(360, 550, 'ballBlue', function ()
        {
            Golf.ball = 'ballBlue';
            this.glow.destroy();
            this.glow = this.add.sprite(342, 532, 'glow');
            this.glow.scale.setTo(2.5, 2.5);
            this.world.bringToTop(this.blueBall);
        }, this, 1, 0, 2);
        this.blueBall.scale.setTo(2, 2);

        this.redBall = this.add.button(430, 550, 'ballRed', function ()
        {
            Golf.ball = 'ballRed';
            this.glow.destroy();
            this.glow = this.add.sprite(412, 532, 'glow');
            this.glow.scale.setTo(2.5, 2.5);
            this.world.bringToTop(this.redBall);
        }, this, 1, 0, 2);
        this.redBall.scale.setTo(2, 2);

        this.purpleBall = this.add.button(500, 550, 'ballPurple', function ()
        {
            Golf.ball = 'ballPurple';
            this.glow.destroy();
            this.glow = this.add.sprite(482, 532, 'glow');
            this.glow.scale.setTo(2.5, 2.5);
            this.world.bringToTop(this.purpleBall);
        }, this, 1, 0, 2);
        this.purpleBall.scale.setTo(2, 2);
        //Button to move to next screen
        this.continueOnButton = this.add.button(600, 550, 'start', this.continueOn, this, 1, 0, 2);
        this.continueOnButton.scale.setTo(0.7, 0.7);
        //Ball tween for the ball being 'hit' into the 'hole'
        this.ball = this.add.sprite(390, 375, 'ball');
        this.ball.scale.setTo(0.25, 0.25);
        this.scaleTween = this.add.tween(this.ball.scale).to({ x: 1, y: 1 }, 5000, "Linear", true);
        this.upTween = this.add.tween(this.ball).to({ x: 550, y: -140 }, 2000, "Quart.easeOut", true);
        this.time.events.add(Phaser.Timer.SECOND, function ()
        {
            //If not on second screen continue effect
            if (this.unclicked)
            {
                this.add.tween(this.ball).to({ x: 750, y: 650 }, 2000, "Quart.easeIn", true);
            }
        }, this);

        this.time.events.loop(Phaser.Timer.SECOND * 6, function ()
        {
            //If not on second screen continue effect
            if (this.unclicked)
            {
                this.ball = this.add.sprite(390, 375, 'ball');
                this.ball.scale.setTo(0.25, 0.25);
                this.scaleTween = this.add.tween(this.ball.scale).to({ x: 1, y: 1 }, 5000, "Linear", true);
                this.upTween = this.add.tween(this.ball).to({ x: 550, y: -140 }, 2000, "Quart.easeOut", true);
                this.time.events.add(Phaser.Timer.SECOND, function ()
                {
                    this.add.tween(this.ball).to({ x: 750, y: 650 }, 2000, "Quart.easeIn", true);
                }, this);
            }
        }, this);
    },
    continueOn: function ()
    {
        //Remove first screen and load second screen
        this.instruct.loadTexture('instruct');
        this.chooseText.destroy();
        this.ball.destroy();
        this.whiteBall.destroy();
        this.blackBall.destroy();
        this.blueBall.destroy();
        this.redBall.destroy();
        this.purpleBall.destroy();
        this.glow.destroy();
        this.continueOnButton.destroy();
        this.scaleTween.stop();
        this.upTween.stop();
        this.unclicked = false;

        var style =
        {
            font: '60px Arial',
            fill: '#FFFFFF',
            strokeThickness: 4
        }
        this.add.text(300, 100, 'Putt 4 Dough', style);
        style =
        {
            font: '24px',
            fill: '#FFFFFF'
        }
        this.add.text(250, 200, 'Hit the piles of cash to find the hole.\nThe fewer strokes the better.\nHit piles of cash to take strokes off your total,\n5 piles removes 1 stroke.\nUse the hints if you need to,\nbut be careful, every hint has a penalty.', style);

        var button = this.add.button(400, 500, 'start', this.toGame, this, 1, 0, 2);
        button.scale.setTo(0.7, 0.7);
        //Add ball hitting pile animation
        var hole = this.add.sprite(650, 450, 'hole');
        hole.scale.setTo(0.5, 0.5);
        var ball = this.add.sprite(250, 450, 'ball');
        var pile = this.add.sprite(600, 350, 'pile');
        var roll = this.add.tween(ball).to({ x: 600 }, 2000, "Linear", true);
        roll.onComplete.add(function ()
        {
            var emitter = this.add.emitter(670, 400, 100);
            emitter.makeParticles(['cash1', 'cash2', 'cash3']);
            emitter.minParticleScale = 0.1;
            emitter.maxParticleScale = 0.1;
            emitter.start(true, 2000, null, 100);
            pile.destroy();
        }, this);


        this.time.events.loop(Phaser.Timer.SECOND * 5, function ()
        {
            var pile = this.add.sprite(600, 350, 'pile');
            ball.x = 300;
            ball.y = 450;
            var roll = this.add.tween(ball).to({ x: 600 }, 2000, "Linear", true);
            roll.onComplete.add(function ()
            {
                var emitter = this.add.emitter(670, 400, 100);
                emitter.makeParticles(['cash1', 'cash2', 'cash3']);
                emitter.minParticleScale = 0.1;
                emitter.maxParticleScale = 0.1;
                emitter.start(true, 2000, null, 100);
                pile.destroy();
            }, this);
        }, this);
    },
    toGame: function()
    {
        this.state.start('Game');
    },
    update: function ()
    {

    }
};
