
//PREP SOUNDS
  var flipSound = document.getElementById("flipSound"),
      matchSound = document.getElementById("matchSound");

  function flipSfx() { 
      flipSound.play(); 
  }
   function matchSfx() { 
      matchSound.play(); 
  } 

//CREATE A TIMER
  var timer = new koTimer(300);
  ko.applyBindings(timer);
  

  var memory_array = ['http://images.waysideco.ca/Back2school2015/viper_card.png',
                      'http://images.waysideco.ca/Back2school2015/viper_card.png',
                      'http://images.waysideco.ca/Back2school2015/jeep_card.png',
                      'http://images.waysideco.ca/Back2school2015/jeep_card.png',
                       'http://images.waysideco.ca/Back2school2015/fiat_card.png',
                       'http://images.waysideco.ca/Back2school2015/fiat_card.png',
                       'http://images.waysideco.ca/Back2school2015/ram_card.png',
                       'http://images.waysideco.ca/Back2school2015/ram_card.png',
                       'http://images.waysideco.ca/Back2school2015/rt_card.png',
                       'http://images.waysideco.ca/Back2school2015/rt_card.png',
                       'http://images.waysideco.ca/Back2school2015/chrysler_card.png',
                       'http://images.waysideco.ca/Back2school2015/chrysler_card.png',
                     ];
  var memory_values = [];
  var memory_tile_ids = [];
  var tiles_flipped = 0;

    Array.prototype.memory_tile_shuffle = function() {
      var i = this.length, j, temp;
      while(--i > 0) {
        j = Math.floor(Math.random()*(i+1));
        temp = this[j];
        this[j] = this[i];
        this[i] = temp;
        }      
    }

  function newBoard(){
      tiles_flipped = 0;
      var output = '';
      memory_array.memory_tile_shuffle();
      for(var i =0; i < memory_array.length; i++) {
          output += '<div id="tile_'+i+'" class="col-xs-4 col-sm-3 memory-card" style="padding:0px;" onclick="memoryFlipTile(this,\''+memory_array[i]+'\')"></div>';
      }
      // push shuffled cards into the memory board
      document.getElementById('memory_board').innerHTML = output;
      // make each memory-card's height equal to its width
      $('.memory-card').height($('.memory-card').width());
  }
  

  // CARD SIZING

  // resize tiles on window resize
  $(window).resize(function(){
        // If there are multiple elements with the same class, "main"
        $('.memory-card').each(function() {
            $(this).height($(this).width());
        });
  }).resize();

  function memoryFlipTile(tile, val) {
    if(tile.innerHTML == "" && memory_values.length < 2) {
        flipSound.play();
        tile.innerHTML = '<img src="'+ val + '" style="width:100%;height:auto;"/>';
        if(memory_values.length == 0) {
          memory_values.push(val);
          memory_tile_ids.push(tile.id);
        } else if(memory_values.length == 1) {
          memory_values.push(val);
          memory_tile_ids.push(tile.id);
          if(memory_values[0] == memory_values[1]) {
               matchSfx()
              tiles_flipped += 2;
              // clear both arrays
              memory_values = [];
              memory_tile_ids = [];
              //check to see if the whole board is cleared
              if(tiles_flipped == memory_array.length){
                // 3 lines below commented out to toggle modal instead
                // alert("board cleared.... generating nbew board");
                // document.getElementById('memory_board').innerHTML = "";
                // newBoard();
                timer.stop();
                $('#myModal').modal('show')
                var playerScore = timer.TimeElapsedStr();
                $('#player_score').val(playerScore);
              }
          } else {
            function flip2Back(){
              // Flip the 2 tile sback over
              flipSound.play(); 
              var tile_1 = document.getElementById(memory_tile_ids[0]);
              var tile_2 = document.getElementById(memory_tile_ids[1]);
              tile_1.style.background = 'url(http://images.waysideco.ca/Back2school2015/card_backlg.png) cover cover no-repeat';  
              tile_1.innerHTML = "";
              tile_2.style.background = 'url(http://images.waysideco.ca/Back2school2015/card_backlg.png) cover cover no-repeat';    
              tile_2.innerHTML = "";
              //clear both arrays
              memory_values = [];
              memory_tile_ids = [];
            }
            setTimeout(flip2Back, 700);
          }
        }
    }
  }

newBoard();

var restart = function(){
  newBoard();
  timer.reset();
  timer.start();
}

    