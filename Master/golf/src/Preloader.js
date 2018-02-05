EPT.Preloader = function(game) {};
EPT.Preloader.prototype = {
	preload: function() {
		var preloadBG = this.add.sprite((this.world.width-580)*0.5, (this.world.height+150)*0.5, 'loading-background');
		var preloadProgress = this.add.sprite((this.world.width-540)*0.5, (this.world.height+170)*0.5, 'loading-progress');
		this.load.setPreloadSprite(preloadProgress);
		
		this._preloadResources();
	},
	_preloadResources: function() {
		var pack = EPT.Preloader.resources;
		for(var method in pack) {
			pack[method].forEach(function(args) {
				var loader = this.load[method];
				loader && loader.apply(this.load, args);
			}, this);
		}
	},
	create: function() {
		this.state.start('Game');
	}
};
EPT.Preloader.resources = {
	'image': [
		['rock-sm-bot', 'img/stone_sm_bot.png'],
		['rock-sm', 'img/stone_sm.png'],
		['blankbumper', 'img/blank_level3_bumper.png'],
		['bumper', 'img/bumper.png'],
		['rock-med', 'img/stone_med.png'],
		['rock-medbot', 'img/stone_med_bot.png'],
		['rock-side', 'img/stone_side.png'],
		['rock-vert', 'img/stone_vert.png'],
        ['grass-three', 'img/grass-three.jpg'],
        ['reddot', 'img/reddot.jpg'],
        ['rock-long', 'img/rock-long.png'],
        ['grass-two', 'img/grass-two.jpg'],
        ['pondbottom', 'img/pondbottom.png'],
        ['pondtop', 'img/pondtop.png'],
        ['rocksmall', 'img/rocksmall.png'],
        ['rock', 'img/rock.png'],
		['sand', 'img/sand.png'],
		['hole', 'img/hole.png'],
        ['arrow', 'img/arrow.png'],
		['ball', 'img/ball.png'],
        ['grass', 'img/grass.jpg'],
		['overlay', 'img/overlay.png']
	],
	'spritesheet': [
        ['skip', 'img/skip-btn.png', 100, 30],
		['button-start', 'img/button-start.png', 180, 180],
		['button-continue', 'img/button-continue.png', 180, 180],
		['button-mainmenu', 'img/button-mainmenu.png', 180, 180],
		['button-restart', 'img/button-tryagain.png', 180, 180],
		['button-achievements', 'img/button-achievements.png', 110, 110],
		['button-pause', 'img/button-pause.png', 80, 80],
		['button-audio', 'img/button-sound.png', 80, 80],
		['button-back', 'img/button-back.png', 70, 70]
	],
    'atlasXML': [
		['splash', 'img/sprites/splash.png', 'img/sprites/splash.xml'],
		['poweruptop', 'img/sprites/power-up-top.png', 'img/sprites/power-up-top.xml'],
		['powerupbot', 'img/sprites/power-up-bot.png', 'img/sprites/power-up-bot.xml'],
	],
	'audio': [
		['boing', ['sfx/boing.mp3','sfx/boing.ogg']],
		['boost', ['sfx/boost.mp3','sfx/boost.ogg']],
        ['splash', ['sfx/splash.mp3','sfx/splash.ogg']],
		['cheer', ['sfx/cheer.mp3','sfx/cheer.ogg']],
		['putt', ['sfx/putt.mp3','sfx/putt.ogg']],
		['cup', ['sfx/cup.mp3','sfx/cup.ogg']],
		['audio-click', ['sfx/audio-button.m4a','sfx/audio-button.mp3','sfx/audio-button.ogg']]
	]
};
