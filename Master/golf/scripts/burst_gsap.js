<script>
var emitter = document.getElementById("emitter"),
    //the following variables make things configurable. Play around.
    emitterSize = 100,
    dotPool = [],
    dotIndex = 0,
    dotQuantity = 50,
    dotSizeMax = 30,
    dotSizeMin = 10,
    speed = 1,
    gravity = 1;

//just for this demo, we're making the emitter's size dynamic and we set xPercent/yPercent to -50 to accurately center it.
TweenLite.set(emitter, { width:emitterSize, height:emitterSize });

for (var i = dotQuantity - 1; i >= 0; i--) {
  dot = document.createElement("div");
  dot.className = "dot";
  TweenLite.set(dot, { force3D:true });
  emitter.appendChild(dot);
  dotPool[i] = dot;
}

var explosion = new TimelineMax({ repeat: -1 }).call(shootDot, [emitter], null, 2 / dotQuantity);


function shootDot(emitter) {
  var angle, length, dot, i, size, bounds = emitter.getBoundingClientRect();;
  //create all the dots
  dot = dotPool[dotIndex++];
  if (dotIndex === dotQuantity) dotIndex = 0;
  size = getRandom(dotSizeMin, dotSizeMax);
  angle = Math.random() * Math.PI * 2; //random angle
  //figure out the maximum distance from the center, factoring in the size of the dot (it must never go outside the circle), and then pick a random spot along that length where we'll plot the point. 
  length = Math.random() * (emitterSize / 2 - size / 2); 
  //place the dot at a random spot within the emitter, and set its size.
  TweenLite.set(dot, {
    opacity:1,
    x:Math.cos(angle) * length + bounds.left + bounds.width / 2,
    y:Math.sin(angle) * length + bounds.top + bounds.height / 2,
    width:size,
    height:size
  });
  //this is where we do the animation...
  TweenLite.to(dot, 1 + Math.random(), {
    opacity:0,

    physics2D:{
      angle:angle * 180 / Math.PI, //translate radians to degrees
    velocity:(100 + Math.random() * 250) * speed, //initial velocity
      gravity:500 * gravity //you could increase/decrease this to give gravity more or less pull
    }

    //if you'd rather not do physics, you could just animate out directly by using the following 2 lines instead of the physics2D:
   //x:Math.cos(angle) * length * 6, 
    //y:Math.sin(angle) * length * 6
  }, 0);
}


function getRandom(min, max) {
  return min + Math.random() * (max - min);
}

</script>