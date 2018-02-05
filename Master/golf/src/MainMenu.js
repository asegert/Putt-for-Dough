EPT.MainMenu = function(game) {};
EPT.MainMenu.prototype = {
	create: function() {
	
		storageAPI.initUnset('EPT-highscore', 0);
		var highscore = storageAPI.get('EPT-highscore') || 0;
	
		var buttonStart = this.add.button(this.world.width-20, this.world.height-20, 'button-start', this.clickStart, this, 1, 0, 2);
		buttonStart.anchor.set(1);

		this.buttonAudio = this.add.button(this.world.width-20, 20, 'button-audio', this.clickAudio, this, 1, 0, 2);
		this.buttonAudio.anchor.set(1,0);

		EPT._manageAudio('init',this);

		buttonStart.x = this.world.width+buttonStart.width+20;
		this.add.tween(buttonStart).to({x: this.world.width-20}, 500, Phaser.Easing.Exponential.Out, true);
		this.buttonAudio.y = -this.buttonAudio.height-20;
		this.add.tween(this.buttonAudio).to({y: 20}, 500, Phaser.Easing.Exponential.Out, true);
		
	},
	clickAudio: function() {
		if(!EPT._audioStatus) {
			EPT._soundClick.play();
		}
		EPT._manageAudio('switch',this);
	},
	clickEnclave: function() {
		if(!EPT._audioStatus) {
			EPT._soundClick.play();
		}
		window.top.location.href = 'http://enclavegames.com/';
	},
	clickStart: function() {
		if(EPT._audioStatus) {
			EPT._soundClick.play();
		}
		this.game.state.start('Story');
	},
	clickAchievements: function() {
		if(EPT._audioStatus) {
			EPT._soundClick.play();
		}
		this.game.state.start('Achievements');
	}
};