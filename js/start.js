var Golf = Golf || {};

//Checks if game is being played on IE
if(Phaser.Device.ie)
{
    //Checks if the version of IE is lower than 10
    if(Phaser.Device.ieVersion < 10)
    {
        //Displays an error message to alert that the browser needs updated
        var error = document.createElement("DIV");
        error.setAttribute("id", "ieError");
        document.body.appendChild(error);
        document.getElementById("ieError").innerHTML = "Please upgrade your Browser <br><br> <a href = 'https://www.microsoft.com/en-ca/download/internet-explorer.aspx'>Internet Explorer</a><br><a href='https://www.google.com/chrome/browser/desktop/index.html'>Chrome</a><br><a href='https://www.mozilla.org/en-US/firefox/new/'>Firefox</a>";
    
    }
    else
    {
        //If version is higher than 10 run game as normal
        Golf.game = new Phaser.Game(960, 640, Phaser.AUTO);

        Golf.game.state.add('Cache', Golf.CacheState);
        Golf.game.state.add('Boot', Golf.BootState); 
        Golf.game.state.add('Preload', Golf.PreloadState); 
        Golf.game.state.add('Game', Golf.GameState);
        Golf.game.state.add('Story', Golf.StoryState);

        Golf.game.state.start('Cache'); 
    }
}
else
{
    //If not being played on IE run game as normal
    Golf.game = new Phaser.Game(960, 640, Phaser.AUTO);

    Golf.game.state.add('Cache', Golf.CacheState);
    Golf.game.state.add('Boot', Golf.BootState); 
    Golf.game.state.add('Preload', Golf.PreloadState); 
    Golf.game.state.add('Game', Golf.GameState);
    Golf.game.state.add('Story', Golf.StoryState);

    Golf.game.state.start('Cache');
}
