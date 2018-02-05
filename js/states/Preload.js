var Golf = Golf || {};

Golf.PreloadState = {
    preload: function ()
    {
        var preloadBG = this.add.sprite((this.world.width - 580) * 0.5, (this.world.height + 150) * 0.5, 'loading-background');
        var preloadProgress = this.add.sprite((this.world.width - 540) * 0.5, (this.world.height + 170) * 0.5, 'loading-progress');
        this.load.setPreloadSprite(preloadProgress);

        this._preloadResources();
    },
    _preloadResources: function ()
    {
        var pack = {
            'image': [
		                     ['rock-sm-bot', 'assets/images/stone_sm_bot.png'],
		                     ['rock-sm', 'assets/images/stone_sm.png'],
		                     ['bottomblank', 'assets/images/blank_level3_bumper.png'],
		                     ['bumper', 'assets/images/bumper.png'],
		                     ['rock-med', 'assets/images/stone_med.png'],
		                     ['rock-medbot', 'assets/images/stone_med_bot.png'],
		                     ['rock-side', 'assets/images/stone_side.png'],
		                     ['rock-vert', 'assets/images/stone_vert.png'],
                             ['grass-three', 'assets/images/grass-three.jpg'],
                             ['reddot', 'assets/images/reddot.jpg'],
                             ['rock-long', 'assets/images/rock-long.png'],
                             ['grass-two', 'assets/images/grass-two.jpg'],
                             ['pondbottom', 'assets/images/pondbottom.png'],
                             ['pondtop', 'assets/images/pondtop.png'],
                             ['rocksmall', 'assets/images/rocksmall.png'],
                             ['rock', 'assets/images/rock.png'],
		                     ['sand', 'assets/images/sand.png'],
		                     ['hole', 'assets/images/hole.png'],
                             ['arrow', 'assets/images/arrow.png'],
		                     ['ball', 'assets/images/ball.png'],
                             ['grass2', 'assets/images/grass2.jpg'],
		                     ['overlay', 'assets/images/overlay.png'],
                             ['instructions', 'assets/images/instructions.png'],
                             ['ballBlack', 'assets/images/ballBlack.png'],
                             ['ballBlue', 'assets/images/ballBlue.png'],
                             ['ballRed', 'assets/images/ballRed.png'],
                             ['ballPurple', 'assets/images/ballPurple.png'],
                             ['windmill', 'assets/images/windmill.png'],
                             ['blade', 'assets/images/windmillBlade.png'],
                             ['bar', 'assets/images/bumper.png'],
                             ['hole1v1', 'assets/images/hol1v1.png'],
                             ['hole1v2', 'assets/images/hol1v2.png'],
                             ['hole1v3', 'assets/images/hol1v3.png'],
                             ['hole1', 'assets/images/hol1.png'],
                             ['hole1Limit', 'assets/images/hol1Limits.png'],
                             ['pile', 'assets/images/cashPile.png'],
                             ['cash1', 'assets/images/cash1.png'],
                             ['cash2', 'assets/images/cash2.png'],
                             ['cash3', 'assets/images/cash3.png'],
                             ['fence', 'assets/images/fence.png'],
                             ['fence2', 'assets/images/fence2.png'],
                             ['main', 'assets/images/main.png'],
                             ['glow', 'assets/images/selectGlow.png'],
                             ['start', 'assets/images/button_start.png'],
                             ['grass', 'assets/images/grass.png'],
                             ['pond', 'assets/images/pond.png'],
                             ['pondFlip', 'assets/images/pondFlip.png'],
                             ['rockFlip', 'assets/images/stone_medFlip.png'],
                             ['instruct', 'assets/images/instruct.png'],
                             ['powerHint', 'assets/images/powerHint.png'],
                             ['guidelineHint', 'assets/images/guidelineHint.png'],
                             ['endScreen', 'assets/images/winScreen.png'],
                             ['cardTop', 'assets/images/cardTop.png'],
                             ['cardRow', 'assets/images/cardRow.png'],
                             ['cardButton', 'assets/images/cardButton.png'],
                             ['sign', 'assets/images/sign.png'],
                             ['prize', 'assets/images/prizeButton.png']
	                    ],
            'spritesheet': [
                            ['skip', 'assets/images/skip-btn.png', 100, 30],
		                    ['button-start', 'assets/images/button-start.png', 180, 180],
		                    ['button-continue', 'assets/images/button-continue.png', 180, 180],
		                    ['button-mainmenu', 'assets/images/button-mainmenu.png', 180, 180],
		                    ['button-restart', 'assets/images/button-tryagain.png', 180, 180],
		                    ['button-achievements', 'assets/images/button-achievements.png', 110, 110],
		                    ['button-pause', 'assets/images/button-pause.png', 80, 80],
		                    ['button-audio', 'assets/images/button-sound.png', 80, 80],
		                    ['button-back', 'assets/images/button-back.png', 70, 70],
                            ['pileHint', 'assets/images/pileHint.png', 150, 140]
	                       ],
            'atlasXML': [
		                    ['splash', 'assets/images/sprites/splash.png', 'assets/images/sprites/splash.xml'],
		                    ['poweruptop', 'assets/images/sprites/power-up-top.png', 'assets/images/sprites/power-up-top.xml'],
		                    ['powerupbot', 'assets/images/sprites/power-up-bot.png', 'assets/images/sprites/power-up-bot.xml'],
	                    ],
            'audio': [
		                    ['boing', ['assets/audio/boing.mp3', 'assets/audio/boing.ogg']],
		                    ['boost', ['assets/audio/boost.mp3', 'assets/audio/boost.ogg']],
                            ['splash', ['assets/audio/splash.mp3', 'assets/audio/splash.ogg']],
		                    ['cheer', ['assets/audio/cheer.mp3', 'assets/audio/cheer.ogg']],
		                    ['putt', ['assets/audio/putt.mp3', 'assets/audio/putt.ogg']],
		                    ['cup', ['assets/audio/cup.mp3', 'assets/audio/cup.ogg']],
		                    ['audio-click', ['assets/audio/audio-button.m4a', 'assets/audio/audio-button.mp3', 'assets/audio/audio-button.ogg']]
	                    ],
            'text': [
                            ['holeData', 'assets/data/holes.json'],
                        ],
            'video': [
                            ['windmillHole', 'assets/video/windmillHole.mp4', 'canplaythrough', true],
                        ]
        };
        for (var method in pack)
        {
            pack[method].forEach(function (args)
            {
                var loader = this.load[method];
                loader && loader.apply(this.load, args);
            }, this);
        }
    },
    create: function ()
    {
        this.state.start('Story');
    }
    //JSON holds the level data as a level array each new enry is a new level. Each level has a velocity for the ball, a max power which is the limit for the speed,
    //hole information containing the x and y coordinates and an x and y scale value,
    //a rowData value which holds the hole number, the par for the hole, strokes, pilesHit, penalties, and a score for those that are not preassigned a value they should be "-",
    //piles information containing a minimum x and y value, a maximum x and y value, a cover x and y value indicating the coordinates of the hole to be covered, and the number of holes to create
    //fence information containing x and y values and a texture value for the Left, Right, Back, Left Front, and Right Front fences,
    //pond information stored as an array containing x and y coordinates and a flip value indicating whether or not the item needs to be rotated for each entry,
    //rock information stored as an array containing x and y coordinates and a flip value indicating whether or not the item needs to be rotated for each entry,
    //sand information stored as an array containing x and y coordinates and a flip value indicating whether or not the item needs to be rotated for each entry
};