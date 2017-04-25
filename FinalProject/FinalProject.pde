/*
Danny Nguyen
 CRPC 1310
 Interactive Bubble Generator
 Credits to "Simple Asteroids Game" by Donya Quick
 
 goals : 
 - Bubbles appear when you press your spacebar key
 x Bubbles rise naturally 
 x Bubbles bounded by window
 x Bubbles popped by users when mousePressed
 x Bubbles will fade and show splash effect
 x Splash effect will be mini shapes exploding out of bubble
 x Make splash/extra shapes disappear after some time
 
 ISSUES : It gets laggy, how to use key function, further aesthetics
 */

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
long defMin = 500;
long defMax = 2000;
long minSpawnTime = 1000;
long maxSpawnTime = 2000;
long nextSpawnTime = round(random(minSpawnTime, maxSpawnTime));
float mSize = 30;
boolean canPop = true;
int currFrames = 0;
int framesToPop = 50;



void setup() {
  frameRate(60);
  size(800, 800);
  noCursor();
}

void draw() { 

  if (currFrames >= framesToPop) {
    canPop = true;
    currFrames = 0;
  }
  currFrames++;

  //fade out bubble trails
  fill(255, 50);
  rect(-5, -5, width+5, height+5);

  //time spawning of Bubbles
  if (millis() > nextSpawnTime) {
    long lower = round(minSpawnTime);
    long upper = round(maxSpawnTime);
    nextSpawnTime = nextSpawnTime + round(random(lower, upper));


    bubbles.add(new Bubble()); //SPAWN BUBBLES
  }
  // Draw Bubbles
  for (int i = bubbles.size()-1; i>=0; i--) { //to-do: traverse this backwards
    (bubbles.get(i)).drawShape();
    (bubbles.get(i)).move(); 
    //Remove bubbles if it reaches the top or if it is clicked
    if (!bubbles.get(i).alive || bubbles.get(i).popTop()) {
      //Create splash effect if it hits the top of the window
      Bubble toPop = bubbles.get(i);
      bubbles.remove(i);
      
      Bubble a1 = new Bubble();
      Bubble a2 = new Bubble();
      Bubble a3 = new Bubble();
      Bubble a4 = new Bubble();
      
      float x1 = random(-0.1, 0);
      float x2 = random(0, 0.1);
      float newSize = toPop.aSize/16;
      float y1 = random(0.0, 0.2);

      a1.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x1, y1);
      a2.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y1);
      a3.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x1, y1);
      a4.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y1);

      bubbles.add(a1);
      bubbles.add(a2);
      bubbles.add(a3);
      bubbles.add(a4);
    }
  }

  // draw an indicator of where the cursor is
  stroke(0, 0, 255, 50);
  strokeWeight(1);
  line(mouseX-5, mouseY-5, mouseX+5, mouseY+5);
  line(mouseX+5, mouseY-5, mouseX-5, mouseY+5);
}

void mousePressed() { // user directly popping bubbles upon click
  if (canPop) { // is it recharged?
    canPop = false; // set the cooldown
    currFrames = 0; // reset the firing cooldown

    // Splash effect when bubble pops
    for ( int i = bubbles.size()-1; i>=0; i--) {
      if (bubbles.get(i).isPopped() || bubbles.get(i).popTop()) {
        Bubble toPop = bubbles.get(i);
        bubbles.remove(i);
        
        Bubble a1 = new Bubble();
        Bubble a2 = new Bubble();
        Bubble a3 = new Bubble();
        Bubble a4 = new Bubble();
        
        float x1 = random(-0.2, -0.1);
        float x2 = random(-0.1, 0);
        float x3 = random(0, 0.1);
        float x4 = random(0.1, 0.2);
        float newSize = toPop.aSize/16;
        float y1 = random(0.0, 0.2);
        float y2 = random(-0.2, 0.0);
        float y3 = 0;

        a1.splashes(toPop.x + random(-1, 1), toPop.y, newSize, x1, y1);
        a2.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y3);
        a3.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x3, y2);
        a4.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x4, y3);
        
        bubbles.add(a1);
        bubbles.add(a2);
        bubbles.add(a3);
        bubbles.add(a4);
      }
    }
  }
}