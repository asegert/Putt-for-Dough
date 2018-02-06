var Golf = Golf || {};

Golf.GameState = {
    create: function ()
    {
        //Stores all data from JSON file
        this.allData = JSON.parse(this.game.cache.getText('holeData'));
        //Background
        this.background = this.add.sprite(0, 0, 'grass');
        //Tracks user specifics
        this.strokes = 0;
        this.score = 0;
        this.piles = 0;
        //Tracks level
        this.level = 0;
        //Holds any carryover from piles hit (%5)
        this.carryOver = 0;
        this.penalties = 0;
        //Calculates an appropriate number of piles to be removed when pile removed hint is used
        this.pileFactor = 0;
        this.gameOver = false;
        this.inHole = false;
        //If the 'drop in hole' tween is active
        this.tweening = false;
        //Text
        this.strokeText = this.add.text(50, 50, 'Strokes: 0', { fill: '#FFFFFF' });
        this.pilesHitText = this.add.text(400, 50, 'Piles Hit: 0', { fill: '#FFFFFF' });
        this.penaltiesText = this.add.text(750, 50, 'Penalties: 0', { fill: '#FF0000' });
        this.physics.startSystem(Phaser.Physics.ARCADE);
        //Groups
        this.obstacles = this.add.group();
        this.fences = this.add.group();
        this.ponds = this.add.group();
        this.rocks = this.add.group();
        this.sands = this.add.group();
        //Row Data contains: Hole num, par, strokes, piles hit, penalties, score
        this.rowData = [];
        for (var i = 0; i < this.allData.Levels.length; i++)
        {
            this.rowData[this.rowData.length] = [this.allData.Levels[i].rowData.holeNum, this.allData.Levels[i].rowData.par, this.allData.Levels[i].rowData.strokes, this.allData.Levels[i].rowData.pilesHit, this.allData.Levels[i].rowData.penalties, this.allData.Levels[i].rowData.score];
        }
        //Show the first hole
        this.showHole(0);
        //Indicates if game input should be paused
        this.pauseInput = false;
        //Creates the power bar and power arrow
        this.bar = this.add.sprite(150, 550, 'bar');
        this.bar.rotation -= 1.56;
        this.bar.alpha = 0;
        this.arrow = this.add.sprite(500, 550, 'arrow');
        this.arrow.scale.setTo(0.5, 0.5);
        this.arrow.anchor.x = 0.5;
        this.arrow.anchor.y = 1;
        this.arrow.pivot.x = 0;
        this.arrow.pivot.y = +1;
        this.power = 0;
        this.powerGo = false;
        this.direction = true;
        //Create a ball
        this.ball = this.add.sprite(500, 550, Golf.ball);
        this.ball.anchor.x = 0.5;
        this.ball.anchor.y = 0.5;
        this.ball.inputEnabled = true;
        this.game.physics.arcade.enable(this.ball);
        this.ball.body.collideWorldBounds = true;
        this.ball.body.onWorldBounds = new Phaser.Signal();
        this.ball.body.onWorldBounds.add(function ()
        {
            this.ball.body.velocity.x = 0;
            this.ball.body.velocity.y = 0;
            this.ball.x = 500;
            this.ball.y = 550;
        }, this);
        this.ball.body.bounce.setTo(1, 1);
        this.ball.scale.setTo(0.5, 0.5);
        //Used to check if the ball has come to a hold
        this.ball.body.drag.setTo(this.balldrag, this.balldrag);
        //Creates a guideline for the ball
        this.line = this.add.bitmapData(960, 640);
        this.line.ctx.strokeStyle = 'rgba(255, 0, 0, 10)';
        this.line.ctx.lineWidth = 2;
        this.line.ctx.lineCap = "round";
        this.lineSprite = this.add.sprite(0, 0, this.line);
        this.lineSprite.alpha = 0;
        //Indicates whether or not the guide has been activated
        this.guide = false;

        this.game.input.onDown.add(function ()
        {
            //Checks if input should be paused or cursor is over buttons in which case input should not be active
            if (this.pauseInput || (this.game.input.activePointer.x > 630 && this.game.input.activePointer.x < 960) && (this.game.input.activePointer.y > 480 && this.game.input.activePointer.y < 650))
            {

            }
            else if (this.ball.body.velocity.y == 0 && this.ball.body.velocity.x == 0 && !this.inHole)
            {
                //Start power adjustment
                this.powerGo = true;
                this.arrow = this.add.sprite(this.ball.x, this.ball.y, 'arrow');
                this.arrow.scale.setTo(0.5, 0.5);
                this.arrow.anchor.x = 0.5;
                this.arrow.anchor.y = 1;
                this.arrow.pivot.x = 0;
                this.arrow.pivot.y = +1;
                this.arrow.down = true;
                if (this.guide)
                {
                    this.lineSprite.alpha = 1;
                }
                this.world.bringToTop(this.ball);
            }
        }, this);
        this.game.input.onUp.add(function ()
        {
            //Checks if power has been calculated via input down or input should be paused or cursor is over buttons in which case input should not be active
            if (!this.powerGo || this.pauseInput || (this.game.input.activePointer.x > 630 && this.game.input.activePointer.x < 960) && (this.game.input.activePointer.y > 480 && this.game.input.activePointer.y < 650))
            {

            }
            else if (this.ball.body.velocity.y == 0 && this.ball.body.velocity.x == 0 && !this.inHole)
            {
                //Play putting sound effect, quiet the background while it plays
                Golf.music.volume = 0.7;
                var sound = this.add.audio('putt');
                sound.play();
                sound.onStop.add(function()
                {
                    Golf.music.volume = 1;
                }, this);
                //Set ball movement
                this.powerGo = false;
                var angle = this.arrow.rotation - (Math.PI / 2);
                this.ball.body.velocity.x = (this.power + 50) * Math.cos(angle);
                this.ball.body.velocity.y = (this.power + 50) * Math.sin(angle);
                this.strokes++;
                this.arrow.destroy();
                this.lineSprite.alpha = 0;
            }
        }, this);

        //Hint Buttons
        this.pileHint = this.add.button(630, 488, 'pileHint', function ()
        {
            if (!this.pauseInput)
            {
                //Remove Piles using pilefactor
                if (this.frame < 2 && Golf.GameState.obstacles.length < (Golf.GameState.pileFactor * 2))
                {
                    var temp = Golf.GameState.obstacles.length;

                    var t = temp % 3;
                    t = temp - t;
                    Golf.GameState.pileFactor = t / (3 - (this.frame));
                }
                if (Golf.GameState.obstacles.length < (Golf.GameState.pileFactor * 2))
                {
                    Golf.GameState.obstacles.removeAll();
                    this.alpha = 0.5;
                }
                else
                {
                    this.frame = this.frame + 1;
                    var limit = Golf.GameState.obstacles.length - Golf.GameState.pileFactor;
                    for (var i = Golf.GameState.obstacles.length - 1; i > limit; i--)
                    {
                        Golf.GameState.obstacles.getChildAt(i).destroy();
                    }
                }

                //Penalty
                var penalty = Golf.GameState.rowData[Golf.GameState.level][1] - (Golf.GameState.rowData[Golf.GameState.level][1] % 3);
                Golf.GameState.penalties += penalty / 3;
            }
        });
        this.guideHint = this.add.button(850, 500, 'guidelineHint', function ()
        {
            if (!this.pauseInput)
            {
                //Add guideline
                this.alpha = 0.5;
                Golf.GameState.guide = true;
                Golf.GameState.penalties += 2;
            }
        });
        this.powerHint = this.add.button(750, 500, 'powerHint', function ()
        {
            if (!this.pauseInput)
            {
                //Add power bar
                Golf.GameState.bar.alpha = 1;
                this.alpha = 0.5;
                Golf.GameState.penalties += 1;
            }
        });
        this.pileHint.scale.setTo(0.78, 0.78);
        this.guideHint.scale.setTo(0.78, 0.78);
        this.powerHint.scale.setTo(0.78, 0.78);
    },
    update: function ()
    {
        //If the game is still being played
        if (!this.gameOver)
        {
            //Update text
            this.strokeText.setText('Strokes: ' + this.strokes);
            this.pilesHitText.setText('Piles Hit: ' + this.piles);
            this.penaltiesText.setText('Penalties: ' + this.penalties);
            //Bring text to top
            this.world.bringToTop(this.strokeText);
            this.world.bringToTop(this.pilesHitText);
            this.world.bringToTop(this.penaltiesText);
            //Render the guideline so it moves with the mouse
            this.line.clear();
            this.line.ctx.beginPath();
            this.line.ctx.moveTo(this.ball.x, this.ball.y);
            this.line.ctx.lineTo(this.game.input.x, this.game.input.y);
            this.line.ctx.stroke();
            this.line.render();
            this.world.bringToTop(this.arrow);
            this.world.bringToTop(this.ball);
            //Update the balls velocity if...
            //It is in motion
            if (this.ball.body.velocity.y != 0 && this.ball.body.velocity.y != 0 && !this.inHole)
            {
                this.ball.body.velocity.x = (this.ball.body.velocity.x * this.allData.Levels[this.level].velocity);
                this.ball.body.velocity.y = (this.ball.body.velocity.y * this.allData.Levels[this.level].velocity);
            }
            //It is slow enough that it should be stopped
            if ((this.ball.body.velocity.y < 15 && this.ball.body.velocity.y > -15) && (this.ball.body.velocity.x < 15 && this.ball.body.velocity.x > -15) && !this.inHole)
            {
                this.ball.body.velocity.x = 0;
                this.ball.body.velocity.y = 0;
                this.arrow.x = this.ball.x;
                this.arrow.y = this.ball.y;
            }
            //Check if ball collided with a pile
            this.physics.arcade.collide(this.ball, this.obstacles, function (ball, obstacle)
            {
                //Play hole drop sound effect, quiet the background while it plays
                Golf.music.volume = 0.7;
                var sound = Golf.GameState.add.audio('pileHit');
                sound.play();
                sound.onStop.add(function()
                {
                    Golf.music.volume = 1;
                }, this);
                //Launch emitter and destroy the pile
                obstacle.emitter.x = obstacle.x;
                obstacle.emitter.y = obstacle.y;
                obstacle.emitter.start(true, 2000, null, 10);
                obstacle.destroy();
                ball.body.velocity.x = (ball.body.velocity.x * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                ball.body.velocity.y = (ball.body.velocity.y * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                Golf.GameState.piles++;
            });
            //Check if ball collided with a fence
            this.physics.arcade.collide(this.ball, this.fences, function (ball)
            {
                //Give ball a 'bounce boost'
                ball.body.velocity.x = (ball.body.velocity.x * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                ball.body.velocity.y = (ball.body.velocity.y * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                
                //Play hit sound effect, quiet the background while it plays
                Golf.music.volume = 0.5;
                var sound = Golf.GameState.add.audio('rockHit');
                sound.play();
                sound.onStop.add(function()
                {
                    Golf.music.volume = 1;
                }, this);
            });
            //Check if ball collided with a rock
            this.physics.arcade.collide(this.ball, this.rocks, function (ball)
            {
                //Give ball a 'bounce boost'
                ball.body.velocity.x = (ball.body.velocity.x * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                ball.body.velocity.y = (ball.body.velocity.y * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity + 0.004));
                
                //Play hit sound effect, quiet the background while it plays
                Golf.music.volume = 0.5;
                var sound = Golf.GameState.add.audio('rockHit');
                sound.play();
                sound.onStop.add(function()
                {
                    Golf.music.volume = 1;
                }, this);
            });
            //Check if ball overlapped with the sand
            this.physics.arcade.overlap(this.ball, this.sands, function (ball)
            {
                //Slow ball dramatically
                ball.body.velocity.x = (ball.body.velocity.x * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity - 0.04));
                ball.body.velocity.y = (ball.body.velocity.y * (Golf.GameState.allData.Levels[Golf.GameState.level].velocity - 0.04));
                if(ball.body.velocity.x != 0 && ball.body.velocity.y != 0 && Golf.music.volume != 1)
                {
                    //Play sand trap sound effect, quiet the background while it plays
                    Golf.music.volume = 0.5;
                    var sound = Golf.GameState.add.audio('sandTrap');
                    sound.play();
                    sound.onStop.add(function()
                    {
                        Golf.music.volume = 1;
                    }, this);
                }
            });
            //Check if ball overlapped with the pond
            this.physics.arcade.overlap(this.ball, this.pond, function (ball)
            {
                //Create a splash and reset ball
                if (Golf.GameState.splashing == undefined)
                {
                    //Play splashing sound effect, quiet the background while it plays
                    Golf.music.volume = 0.5;
                    var sound = Golf.GameState.add.audio('splash');
                    sound.play();
                    sound.onStop.add(function()
                    {
                        Golf.music.volume = 1;
                    }, this);
                    //Creates the splashing animation
                    Golf.GameState.splashing = true;
                    Golf.GameState.sprite = Golf.GameState.add.sprite(ball.x - 50, ball.y - 50, 'splash');
                    var anim = Golf.GameState.sprite.animations.add('splash', [0, 1, 2, 3, 4, 5, 6, 7], 8, true);
                    anim.play(60, false);
                    anim.onComplete.add(function ()
                    {
                        Golf.GameState.splashing = undefined;
                        Golf.GameState.sprite.destroy();

                        var style =
                        {
                            fill: '#FF0000'
                        }

                        //Creates the flashing text emphasizing the additional stroke added
                        Golf.GameState.strokes++;
                        var flashText = Golf.GameState.add.text(50, 50, 'Strokes: ' + Golf.GameState.strokes, style);
                        Golf.GameState.world.bringToTop(flashText);
                        var flash = Golf.GameState.add.tween(Golf.GameState.strokeText).to({ alpha: 0 }, 1500, "Linear", true);
                        flash.onComplete.add(function()
                        {
                            var unflash = Golf.GameState.add.tween(Golf.GameState.strokeText).to({ alpha: 1 }, 1000, "Linear", true);
                            unflash.onComplete.add(function()
                            {
                                flashText.destroy();
                            }, this);
                        }, this);
                    }, this);
                    ball.x = 500;
                    ball.y = 550;
                    ball.body.velocity.x = 0;
                    ball.body.velocity.y = 0;
                }
            });
            //Check if ball overlapped with the hole
            this.physics.arcade.overlap(this.ball, this.hole, function (ball, hole)
            {
                //Play hole drop sound effect, quiet the background while it plays
                Golf.music.volume = 0.7;
                var sound = Golf.GameState.add.audio('hole');
                sound.play();
                sound.onStop.add(function()
                {
                    Golf.music.volume = 1;
                }, this);
                //If the tween is not already running, run it
                if (!Golf.GameState.tweening)
                {
                    Golf.GameState.tweening = true;
                    ball.body.velocity.x = 0;
                    ball.body.velocity.y = 0;
                    Golf.GameState.inHole = true;
                    Golf.GameState.add.tween(ball).to({ x: hole.x + (hole.width / 2), y: hole.y + (hole.height / 2) }, 500, "Linear", true);
                    var scaleTween = Golf.GameState.add.tween(ball.scale).to({ x: 0.25, y: 0.25 }, 500, "Linear", true);
                    scaleTween.onComplete.add(function ()
                    {
                        Golf.GameState.level++;
                        Golf.GameState.showHole(Golf.GameState.level);
                        Golf.GameState.inHole = false;
                        Golf.GameState.tweening = false;
                    }, this);
                }
            });
            //Update the power while input is down
            if (this.powerGo && this.direction)
            {
                this.power++;
            }
            else if (this.powerGo && !this.direction)
            {
                this.power--;
                if (this.power < 0)
                {
                    this.power = 0;
                }
            }
            if (this.power == this.allData.Levels[this.level].powerMax || this.power == 0)
            {
                this.direction = !this.direction;
            }
            //Adjust the power indicators
            this.bar.scale.setTo(1, 0.01 * this.power);
            this.arrow.scale.setTo(1, 0.01 * this.power);
            //Rotate the arrow/direction
            if (Golf.game.input.activePointer.x > this.ball.x)
            {
                this.arrow.rotation = this.game.math.angleBetween(this.ball.body.x, this.ball.body.y, this.game.input.x, this.game.input.y) + Math.PI / 2;
            }
            else if (Golf.game.input.activePointer.x < this.ball.x)
            {
                this.arrow.rotation = this.game.math.angleBetween(this.ball.body.x, this.ball.body.y, this.game.input.x, this.game.input.y) + Math.PI / 2;
            }
        }
    },
    showHole: function (hole)
    {
        //If it is the first hole set everything to default
        if (hole == 0)
        {
            this.createFence();
            this.parSign = this.add.sprite(80, 600, 'sign');
            this.par = this.add.text(-35, -80, "Par " + this.rowData[this.level][1], { fill: '#FFFFFF' });
            this.parSign.addChild(this.par);
            this.parSign.anchor.setTo(0.5, 1);
            this.parSign.rotation = -0.3;
            var tween = this.add.tween(this.parSign).to({ rotation: 0.3 }, 5000, "Linear", true, 0, -1);
            tween.yoyo(true, 0);
            this.hole = this.add.sprite(this.allData.Levels[this.level].hole.x, this.allData.Levels[this.level].hole.y, 'hole');
            this.game.physics.arcade.enable(this.hole);
            this.hole.scale.setTo(this.allData.Levels[this.level].hole.scalex, this.allData.Levels[this.level].hole.scaley);
            this.createPiles(this.allData.Levels[this.level].piles.minx, this.allData.Levels[this.level].piles.miny, this.allData.Levels[this.level].piles.maxx, this.allData.Levels[this.level].piles.maxy, this.allData.Levels[this.level].piles.coverx, this.allData.Levels[this.level].piles.covery, this.allData.Levels[this.level].piles.num);

            this.world.bringToTop(this.obstacles);
        }
        //If it is not the first hole reset buttons and other set up options
        else if (hole > 0 && hole < this.rowData.length)
        {
            //Reset hint buttons
            this.pileHint.frame = 0;
            this.pileHint.alpha = 1;

            Golf.GameState.guide = false;
            this.guideHint.alpha = 1;

            Golf.GameState.bar.alpha = 0;
            this.powerHint.alpha = 1;

            this.par.setText("Par " + this.rowData[this.level][1]);
            this.ball.body.velocity.x = 0;
            this.ball.body.velocity.y = 0;
            this.ball.x = 500;
            this.ball.y = 550;
            this.ball.scale.setTo(0.5, 0.5);
            this.obstacles.removeAll();
            this.rocks.forEach(function (r)
            {
                r.destroy();
            });
            this.rocks.removeAll();
            this.sands.forEach(function (s)
            {
                s.destroy();
            });
            this.sands.removeAll();
            this.ponds.forEach(function (p)
            {
                p.destroy();
            });
            this.ponds.removeAll();
            this.hole.x = this.allData.Levels[this.level].hole.x;
            this.hole.y = this.allData.Levels[this.level].hole.y;
            this.createPiles(this.allData.Levels[this.level].piles.minx, this.allData.Levels[this.level].piles.miny, this.allData.Levels[this.level].piles.maxx, this.allData.Levels[this.level].piles.maxy, this.allData.Levels[this.level].piles.coverx, this.allData.Levels[this.level].piles.covery, this.allData.Levels[this.level].piles.num);
            this.world.bringToTop(this.obstacles);
            this.proceed(false);
        }
        else
        {
            //If there are no more holes end the game
            this.endGame();
        }
    },
    createPiles: function (minX, minY, maxX, maxY, coverX, coverY, num)
    {
        //Set the initial pile factor based on how many piles are being created
        var n = num + 1;
        if (n % 3 != 0)
        {
            n = (num + 1) % 3;
            n = (num + 1) - n;
            n = n / 3;
        }
        this.pileFactor = n;
        //Create the emitter to run when the pile is hit
        var emitter = this.add.emitter(coverX, coverY, 100);
        emitter.makeParticles(['cash1', 'cash2', 'cash3']);
        emitter.minParticleScale = 0.1;
        emitter.maxParticleScale = 0.1;
        //Create the pile and attach the emitter
        this.pile = this.add.sprite(coverX, coverY, 'pile');
        this.pile.scale.setTo(0.4, 0.4);
        this.pile.anchor.setTo(0.5, 0.5);
        this.pile.inputEnabled = true;
        this.game.physics.arcade.enable(this.pile);
        this.pile.body.collideWorldBounds = true;
        this.pile.body.immovable = true;
        this.pile.body.checkCollision.up = true;
        this.pile.body.checkCollision.down = true;
        this.pile.body.checkCollision.left = true;
        this.pile.body.checkCollision.right = true;
        this.pile.emitter = emitter;
        //Add the pile to the obstacles group
        this.obstacles.add(this.pile);
        //Update the grid to reflect the location of the pile to avoid layering the pile with another
        var x = ((maxX - minX) / 50) + 1;
        var y = ((maxY - minY) / 50) + 1;
        var grid = new Array(x);
        for (var i = 0; i < x; i++)
        {
            grid[i] = new Array(y);
            for (var j = 0; j < y; j++)
            {
                grid[i][j] = 0;
            }
        }
        grid[((coverX - minX) / 50)][((coverY - minY) / 50)] = 1;
        //Update the grid with the locations of rocks, ponds, and sands
        for (var k = 0; k < this.allData.Levels[this.level].ponds.length; k++)
        {
            grid = this.addPond(this.allData.Levels[this.level].ponds[k].x, this.allData.Levels[this.level].ponds[k].y, grid, this.allData.Levels[this.level].ponds[k].flip);
        }
        for (var k = 0; k < this.allData.Levels[this.level].rocks.length; k++)
        {
            grid = this.addRock(this.allData.Levels[this.level].rocks[k].x, this.allData.Levels[this.level].rocks[k].y, grid, this.allData.Levels[this.level].rocks[k].flip);
        }
        for (var k = 0; k < this.allData.Levels[this.level].sands.length; k++)
        {
            grid = this.addSand(this.allData.Levels[this.level].sands[k].x, this.allData.Levels[this.level].sands[k].y, grid, this.allData.Levels[this.level].sands[k].flip);
        }
        //Create the remaining piles
        for (var i = 0; i < num; i++)
        {
            var pileX = (Math.floor(Math.random() * (maxX - minX)));
            pileX = (pileX - (pileX % 50));

            var pileY = (Math.floor(Math.random() * (maxY - minY)));
            pileY = (pileY - (pileY % 50));

            if (grid[pileX / 50][pileY / 50] != 0)
            {
                var coinFlip = Math.floor(Math.random() * 2);
                var coords = this.nextGridSpot(grid, pileX / 50, pileY / 50, coinFlip);
                grid[coords.x][coords.y] = 1;
                pileX = coords.x * 50;
                pileY = coords.y * 50;
            }
            else
            {
                grid[pileX / 50][pileY / 50] = 1;
            }

            this.pile = this.add.sprite((minX + pileX), (minY + pileY), 'pile');
            this.pile.scale.setTo(0.4, 0.4);
            this.pile.anchor.setTo(0.5, 0.5);
            this.pile.inputEnabled = true;
            this.game.physics.arcade.enable(this.pile);
            this.pile.body.collideWorldBounds = true;
            this.pile.body.immovable = true;
            this.pile.body.checkCollision.up = true;
            this.pile.body.checkCollision.down = true;
            this.pile.body.checkCollision.left = true;
            this.pile.body.checkCollision.right = true;
            this.pile.emitter = emitter;

            this.obstacles.add(this.pile);
        }
    },
    createFence: function ()
    {
        //Create the fences and add them to the fence group
        var LeftFence = this.add.sprite(this.allData.Levels[this.level].fence.Left.x, this.allData.Levels[this.level].fence.Left.y, this.allData.Levels[this.level].fence.Left.tex);
        LeftFence.rotation += 0.1;
        LeftFence.scale.setTo(1.1, 1.1);
        this.game.physics.arcade.enable(LeftFence);
        LeftFence.body.immovable = true;
        LeftFence.body.checkCollision.up = true;
        LeftFence.body.checkCollision.down = true;
        LeftFence.body.checkCollision.left = true;
        LeftFence.body.checkCollision.right = true;

        var RightFence = this.add.sprite(this.allData.Levels[this.level].fence.Right.x, this.allData.Levels[this.level].fence.Right.y, this.allData.Levels[this.level].fence.Right.tex);
        RightFence.rotation -= 0.1;
        RightFence.scale.setTo(1.1, 1.1);
        this.game.physics.arcade.enable(RightFence);
        RightFence.body.immovable = true;
        RightFence.body.checkCollision.up = true;
        RightFence.body.checkCollision.down = true;
        RightFence.body.checkCollision.left = true;
        RightFence.body.checkCollision.right = true;

        var BackFence = this.add.sprite(this.allData.Levels[this.level].fence.Back.x, this.allData.Levels[this.level].fence.Back.y, this.allData.Levels[this.level].fence.Back.tex);
        BackFence.scale.setTo(2.15, 1.1);
        this.game.physics.arcade.enable(BackFence);
        BackFence.body.immovable = true;
        BackFence.body.checkCollision.up = true;
        BackFence.body.checkCollision.down = true;
        BackFence.body.checkCollision.left = true;
        BackFence.body.checkCollision.right = true;

        var FrontLeftFence = this.add.sprite(this.allData.Levels[this.level].fence.LeftFront.x, this.allData.Levels[this.level].fence.LeftFront.y, this.allData.Levels[this.level].fence.LeftFront.tex);
        FrontLeftFence.scale.setTo(1, 1);
        this.game.physics.arcade.enable(FrontLeftFence);
        FrontLeftFence.body.immovable = true;
        FrontLeftFence.body.checkCollision.up = true;
        FrontLeftFence.body.checkCollision.down = true;
        FrontLeftFence.body.checkCollision.left = true;
        FrontLeftFence.body.checkCollision.right = true;

        var FrontRightFence = this.add.sprite(this.allData.Levels[this.level].fence.RightFront.x, this.allData.Levels[this.level].fence.RightFront.y, this.allData.Levels[this.level].fence.RightFront.tex);
        FrontRightFence.scale.setTo(1, 1);
        this.game.physics.arcade.enable(FrontRightFence);
        FrontRightFence.body.immovable = true;
        FrontRightFence.body.checkCollision.up = true;
        FrontRightFence.body.checkCollision.down = true;
        FrontRightFence.body.checkCollision.left = true;
        FrontRightFence.body.checkCollision.right = true;

        this.fences.add(LeftFence);
        this.fences.add(RightFence);
        this.fences.add(BackFence);
        this.fences.add(FrontLeftFence);
        this.fences.add(FrontRightFence);
    },
    nextGridSpot: function (grid, x, y, coinFlip)
    {
        //Check if the grid at a location is already occupied and move to a close location
        var found = false;
        var oldx = x;
        var oldy = y;
        var foundx = x;
        var foundy = y;
        if (coinFlip == 0)
        {
            while (x < grid.length - 1 && !found)
            {
                x++;
                if (grid[x][y] == 0)
                {
                    found = true;
                    foundx = x;
                }
            }
            x = oldx;
            while (x > 0 && !found)
            {
                x--;
                if (grid[x][y] == 0)
                {
                    found = true;
                    foundx = x;
                }
            }

            while (y < grid.length - 1 && !found)
            {
                y++;
                if (grid[x][y] == 0)
                {
                    found = true;
                    foundy = y;
                }
            }
            y = oldy;
            while (y > 0 && !found)
            {
                y--;
                if (grid[x][y] == 0)
                {
                    found = true;
                    foundy = y;
                }
            }
        }
        else
        {
            while (y < grid.length - 1 && !found)
            {
                y++;
                if (grid[x][y] == 0)
                {
                    grid[x][y] = 1;
                    found = true;
                    foundy = y;
                }
            }
            y = oldy;
            while (y > 0 && !found)
            {
                y--;
                if (grid[x][y] == 0)
                {
                    grid[x][y] = 1;
                    found = true;
                    foundy = y;
                }
            }

            while (x < grid.length - 1 && !found)
            {
                x++;
                if (grid[x][y] == 0)
                {
                    grid[x][y] = 1;
                    found = true;
                    foundx = x;
                }
            }
            x = oldx;
            while (x > 0 && !found)
            {
                x--;
                if (grid[x][y] == 0)
                {
                    grid[x][y] = 1;
                    found = true;
                    foundx = x;
                }
            }
        }
        return { x: foundx, y: foundy };
    },
    calculateScore: function ()
    {
        //Add the current number of piles to the amount of piles carried over from previous holes (<5)
        //Make the new carry over the mod five of the number and calculate the pile multiple of five 
        //Subtract the multiple from the strokes to remove strokes based on piles hit
        //Add penalties to the strokes as the score and reset values 
        var o = this.piles + this.carryOver;
        this.carryOver = o % 5;
        var p = o - (o % 5);
        var s = this.strokes - (p / 5);
        s = s + this.penalties;
        if (s < 0)
        {
            s = 0;
        }
        this.score += s;
        this.strokes = 0;
        this.piles = 0;
        this.penalties = 0;
    },
    addPond: function (x, y, grid, flip)
    {
        var gridx = (x / 50) - 2;
        var gridy = (y / 50) - 2;

        if (flip)
        {
            this.pond = this.add.sprite(x, y, 'pond');
            for (var i = 0; i < 4; i++)
            {
                for (var j = 0; j < 3; j++)
                {
                    //Allows a hazard to overflow the pile area while filling the used grid space
                    if ((gridx + i >= 0 && gridx + i < grid.length) && (gridy + j >= 0 && gridy + j < grid[0].length))
                    {
                        grid[gridx + i][gridy + j] = 1;
                    }
                }
            }
        }
        else
        {
            this.pond = this.add.sprite(x, y, 'pondFlip');
            for (var i = 0; i < 3; i++)
            {
                for (var j = 0; j < 4; j++)
                {
                    //Allows a hazard to overflow the pile area while filling the used grid space
                    if ((gridx + i >= 0 && gridx + i < grid.length) && (gridy + j >= 0 && gridy + j < grid[0].length))
                    {
                        grid[gridx + i][gridy + j] = 1;
                    }
                }
            }
        }
        this.game.physics.arcade.enable(this.pond);
        this.pond.body.immovable = true;
        this.ponds.add(this.pond);

        return grid;
    },
    addRock: function (x, y, grid, flip)
    {
        var gridx = Math.round((x / 50) - 2);
        var gridy = Math.round((y / 50) - 2);

        if (flip)
        {
            this.rock = this.add.sprite(x, y, 'rock-med');
            for (var i = 0; i < 3; i++)
            {
                for (var j = 0; j < 2; j++)
                {
                    //Allows a hazard to overflow the pile area while filling the used grid space
                    if ((gridx + i >= 0 && gridx + i < grid.length) && (gridy + j >= 0 && gridy + j < grid[0].length))
                    {
                        grid[gridx + i][gridy + j] = 1;
                    }
                }
            }
        }
        else
        {
            this.rock = this.add.sprite(x, y, 'rockFlip');
            for (var i = 0; i < 2; i++)
            {
                for (var j = 0; j < 3; j++)
                {
                    //Allows a hazard to overflow the pile area while filling the used grid space
                    if ((gridx + i >= 0 && gridx + i < grid.length) && (gridy + j >= 0 && gridy + j < grid[0].length))
                    {
                        grid[gridx + i][gridy + j] = 1;
                    }
                }
            }
        }
        this.game.physics.arcade.enable(this.rock);
        this.rock.body.immovable = true;
        this.rocks.add(this.rock);

        return grid;
    },
    addSand: function (x, y, grid, flip)
    {
        this.sand = this.add.sprite(x, y, 'sand');
        this.game.physics.arcade.enable(this.sand);
        this.sand.body.immovable = true;
        this.sands.add(this.sand);

        var gridx = (x / 50) - 2;
        var gridy = (y / 50) - 2;

        //Works regardless of flip because both go 3 over
        for (var i = 0; i < 3; i++)
        {
            for (var j = 0; j < 3; j++)
            {
                //Allows a hazard to overflow the pile area while filling the used grid space
                if ((gridx + i >= 0 && gridx + i < grid.length) && (gridy + j >= 0 && gridy + j < grid[0].length))
                {
                    grid[gridx + i][gridy + j] = 1;
                }
            }
        }
        return grid;
    },
    proceed: function (e)
    {
        //Play applause sound effect, quiet the background while it plays
        Golf.music.volume = 0.7;
        var sound = this.add.audio('applause');
        sound.play();
        sound.onStop.add(function()
        {
            Golf.music.volume = 1;
        }, this);
        //Pause the input
        this.pauseInput = true;
        //Set the row's y based on which row it is
        if (this.rowData.length < 17)
        {
            var y = 332 - 60 - ((this.rowData.length / 2) * 34);
        }
        else
        {
            var y = 0;
        }

        //Create the card header
        this.topLeft = this.add.sprite(70, y, 'cardTop');
        this.topRight = this.add.sprite(465, y, 'cardTop');
        this.rows = this.add.group();

        var textStyle =
        {
            font: '30px Arial'
        };
        //Create the header text
        this.headText1 = this.add.text(100, (y + 10), 'Hole', textStyle);
        this.headText2 = this.add.text(240, (y + 10), 'Par', textStyle);
        this.headText3 = this.add.text(350, (y + 10), 'Strokes', textStyle);
        this.headText4 = this.add.text(470, (y + 10), 'Piles Hit', textStyle);
        this.headText5 = this.add.text(600, (y + 10), 'Penalties', textStyle);
        this.headText6 = this.add.text(750, (y + 10), 'Score', textStyle);
        //Indicates that the current hole has been filled
        var filled = false;
        //The last index for the card
        var end = -1;
        //How much to offset the row
        var iOffset = 0;
        for (var i = 0; i < this.rowData.length; i++)
        {
            //If all holes cannot be displayed
            if (this.rowData.length > 16)
            {
                //If last index has been reached break
                if (i == end)
                {
                    break;
                }
                //If the lowest section has been reached start writting rows
                else if (i + 15 == this.rowData.length)
                {
                    end = this.rowData.length;
                    iOffset = i;
                }
                //If an end has not been set and the next row is empty set the next 15 holes to be displayed
                else if (end == -1 && i + 1 != this.rowData.length - 1 && this.rowData[i + 1][2] == "-")
                {
                    end = 15 + i;
                    iOffset = i;
                }
                //If no condition is satisfied do nothing and continue the loop
                else if (end == -1)
                {
                    continue;
                }
            }
            //Else create the row
            this.rowLeft = this.add.sprite(70, (y + 60 + (34 * (i - iOffset))), 'cardRow');
            this.rowRight = this.add.sprite(465, (y + 60 + (34 * (i - iOffset))), 'cardRow');
            //If not filled fill the data
            if (!filled && this.rowData[i][2] == "-")
            {
                this.rowData[i][2] = this.strokes;
                this.rowData[i][3] = this.piles;
                this.rowData[i][4] = this.penalties;
                this.calculateScore();
                this.rowData[i][5] = this.score - this.rowData[i][1];
                this.score = this.score - this.rowData[i][1];
                filled = true;
            }
            //Display the row values
            this.rowText1 = this.add.text(115, this.rowLeft.y, this.rowData[i][0], textStyle);
            this.rowText2 = this.add.text(255, this.rowLeft.y, this.rowData[i][1], textStyle);
            this.rowText3 = this.add.text(390, this.rowLeft.y, this.rowData[i][2], textStyle);
            this.rowText4 = this.add.text(520, this.rowLeft.y, this.rowData[i][3], textStyle);
            this.rowText5 = this.add.text(650, this.rowLeft.y, this.rowData[i][4], textStyle);
            (this.rowData[i][5] > 0) ? textStyle = { font: '30px Arial', fill: '#FF0000'} : textStyle = { font: '30px Arial', fill: '#00FF00' };
            (this.rowData[i][5] == "-" || this.rowData[i][5] == 0) ? textStyle = { font: '30px Arial', fill: '#000000'} : textStyle = textStyle;
            this.rowText6 = this.add.text(770, this.rowLeft.y, this.rowData[i][5], textStyle);
            textStyle = { font: '30px Arial' };
            //Add the row components to the rows group
            this.rows.add(this.rowLeft);
            this.rows.add(this.rowRight);
            this.rows.add(this.rowText1);
            this.rows.add(this.rowText2);
            this.rows.add(this.rowText3);
            this.rows.add(this.rowText4);
            this.rows.add(this.rowText5);
            this.rows.add(this.rowText6);
        }
        //Create the button to continue on, start to play the next hole, prize to end the game and claim the prize
        var texture = 'start';
        var coord1 = 800;
        var coord2 = 580;
        if (this.level == this.rowData.length)
        {
            texture = 'prize';
            coord1 = 700;
            coord2 = 550;
        }
        this.nextButton = this.add.button(coord1, coord2, texture, function ()
        {
            this.topLeft.destroy();
            this.topRight.destroy();
            this.rows.removeAll();
            this.headText1.destroy();
            this.headText2.destroy();
            this.headText3.destroy();
            this.headText4.destroy();
            this.headText5.destroy();
            this.headText6.destroy();
            this.nextButton.destroy();
            this.pauseInput = false;

            //If game is over submit the form
            if (this.level == this.rowData.length)
            {
                document.getElementById('form1').submit();
            }
        }, this);
        this.nextButton.scale.setTo(0.5, 0.5);
        //If elements are not o be shown (button press at end)
        if (e)
        {
            this.topLeft.alpha = 0;
            this.topRight.alpha = 0;
            this.rows.forEach(function (row)
            {
                row.alpha = 0;
            }, this);
            this.headText1.alpha = 0;
            this.headText2.alpha = 0;
            this.headText3.alpha = 0;
            this.headText4.alpha = 0;
            this.headText5.alpha = 0;
            this.headText6.alpha = 0;
        }
        else
        {
            this.nextButton.alpha = 1;
            this.topLeft.alpha = 1;
            this.topRight.alpha = 1;
            this.rows.forEach(function (row)
            {
                row.alpha = 1;
            }, this);
            this.headText1.alpha = 1;
            this.headText2.alpha = 1;
            this.headText3.alpha = 1;
            this.headText4.alpha = 1;
            this.headText5.alpha = 1;
            this.headText6.alpha = 1;
        }
    },
    endGame: function ()
    {
        //Play cheering sound effect, quiet the background while it plays
        Golf.music.volume = 0.7;
        var sound = this.add.audio('cheer');
        sound.play();
        sound.onStop.add(function()
        {
            Golf.music.volume = 1;
        }, this);
        //Remove Elements
        this.gameOver = true;
        this.proceed(true);
        this.pauseInput = true;
        this.fences.removeAll();
        this.obstacles.removeAll();
        this.ball.alpha = 0;
        this.hole.destroy();
        this.ponds.removeAll();
        this.rocks.removeAll();
        this.sands.removeAll();
        this.pileHint.destroy();
        this.powerHint.destroy();
        this.guideHint.destroy();
        this.strokeText.destroy();
        this.penaltiesText.destroy();
        this.pilesHitText.destroy();
        this.bar.destroy();
        this.lineSprite.destroy();
        this.par.destroy();
        //Show Background
        this.background.loadTexture('endScreen');
        //Ball animation with all ball colours
        var round = 0;
        var tex = ['ball', 'ballBlack', 'ballBlue', 'ballRed', 'ballPurple'];
        var ballAnim = this.time.events.repeat(Phaser.Timer.SECOND / 6, 5, function ()
        {
            this.ballAnimation(tex[round], round);
            round++;
        }, this);

        //Display Score
        var style =
        {
            fill: '#FFFFFF',
            stroke: '000000',
            strokeThickness: 4
        }
        this.add.text(350, 200, 'Your final Score is ' + this.score, style);
        //Timer b4 submission may replace with button
        this.time.events.add(Phaser.Timer.SECOND * 10, function ()
        {
            document.getElementById('form1').submit;
        }, this);

        this.cardText = this.add.text(-35, -95, 'Scorecard', { fill: '#FFFFFF', font: '18px' });
        this.cardButton = this.add.button(-35, -75, 'cardButton', function ()
        {
            this.proceed(false);
        }, this);

        this.parSign.addChild(this.cardButton);
        this.parSign.addChild(this.cardText);
    },
    ballAnimation: function (ballTex, offset)
    {
        //Final ball animation, just like in story, but with several balls being shot into the 'hole'
        var ball = this.add.sprite(410, 250, ballTex);
        ball.scale.setTo(0.25, 0.25);
        this.scaleTween = this.add.tween(ball.scale).to({ x: 1, y: 1 }, 5000, "Linear", true);
        this.upTween = this.add.tween(ball).to({ x: (600 + (offset * 20)), y: -140 }, 2000, "Quart.easeOut", true);
        this.time.events.add(Phaser.Timer.SECOND, function ()
        {
            this.add.tween(ball).to({ x: 800, y: 650 }, 2000, "Quart.easeIn", true);
        }, this);

        this.time.events.loop(Phaser.Timer.SECOND * 6, function ()
        {
            ball = this.add.sprite(410, 250, ballTex);
            ball.scale.setTo(0.25, 0.25);
            this.scaleTween = this.add.tween(ball.scale).to({ x: 1, y: 1 }, 5000, "Linear", true);
            this.upTween = this.add.tween(ball).to({ x: (600 + (offset * 20)), y: -140 }, 2000, "Quart.easeOut", true);
            this.time.events.add(Phaser.Timer.SECOND, function ()
            {
                this.add.tween(ball).to({ x: 800, y: 650 }, 2000, "Quart.easeIn", true);
            }, this);
        }, this);
    }
};
/*Copyright (C) Wayside Co. - All Rights Reserved
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* Written and maintained by Wayside Co <info@waysideco.ca>, 2018*/