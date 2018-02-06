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
		                     ['rock-med', 'assets/images/stone_med.png'],
		                     ['sand', 'assets/images/sand.png'],
		                     ['hole', 'assets/images/hole.png'],
                             ['arrow', 'assets/images/arrow.png'],
		                     ['ball', 'assets/images/ball.png'],
                             ['ballBlack', 'assets/images/ballBlack.png'],
                             ['ballBlue', 'assets/images/ballBlue.png'],
                             ['ballRed', 'assets/images/ballRed.png'],
                             ['ballPurple', 'assets/images/ballPurple.png'],
                             ['bar', 'assets/images/bumper.png'],
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
                            ['pileHint', 'assets/images/pileHint.png', 150, 140]
	                       ],
            'atlasXML': [
		                    ['splash', 'assets/images/sprites/splash.png', 'assets/images/sprites/splash.xml']
	                    ],
            'audio': [
		                    ['background', ['assets/audio/theStones.mp3', 'assets/audio/theStones.m4a', 'assets/audio/theStones.ogg']],
		                    ['applause', ['assets/audio/applause.mp3', 'assets/audio/applause.m4a', 'assets/audio/applause.ogg']],
                            ['sandTrap', ['assets/audio/sandTrap.mp3', 'assets/audio/sandTrap.m4a', 'assets/audio/sandTrap.ogg']],
                            ['rockHit', ['assets/audio/rockHit.mp3', 'assets/audio/rockHit.mp3', 'assets/audio/rockHit.ogg']],
                            ['pileHit', ['assets/audio/pileHit.mp3', 'assets/audio/pileHit.m4a', 'assets/audio/pileHit.ogg']],
                            ['splash', ['assets/audio/splash.mp3', 'assets/audio/splash.m4a', 'assets/audio/splash.ogg']],
		                    ['cheer', ['assets/audio/cheer.mp3', 'assets/audio/cheer.m4a', 'assets/audio/cheer.ogg']],
		                    ['putt', ['assets/audio/putt.mp3', 'assets/audio/putt.m4a', 'assets/audio/putt.ogg']],
                            ['hole', ['assets/audio/cup.mp3', 'assets/audio/cup.m4a', 'assets/audio/cup.ogg']]
	                    ],
            'text': [
                            ['holeData', 'assets/data/holes.json'],
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
/*Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2018*/