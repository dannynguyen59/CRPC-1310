/*
Danny Nguyen
 CRPC 1310
 Interactive Bubble Generator by Danny Nguyen
 Credits to "Simple Asteroids Game" by Donya Quick for Meteor to Bubble Coding
 Credits to "LightsOut Demo" by Donya Quick and Class for Audio Coding
 Credits to "doodle_bug_demo3" by Donya Quick and Class for Image processing and Flip
 Credits to PROCESSING FORUM "how to reset count time" by USER: csteinlehner
 Sources: 
 https://processing.org/reference/ (For Help + New code use; text, img, etc)
 http://soundbible.com/ (Sound Effects)
 http://google.com/ (Background Image)
 http://www.maplesimulator.com/programs/bannedstory (Bird Image)
 http://www.dafont.com/ (Font)
 PaintNet (Image editor)
 
 goals : 
 x Bubbles appear when you press your spacebar key
 x Bubbles rise naturally 
 x Bubbles bounded by window
 x Bubbles popped by users when mousePressed
 x Bubbles will fade and show splash effect
 x Splash effect will be mini shapes exploding out of bubble
 x Make splash/extra shapes disappear after some time
 x Aesthetics
 
 */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
ArrayList<Bird> birds = new ArrayList<Bird>();

long defMin = 1000;
long defMax = 1500;
long minSpawnTime = 1000;
long maxSpawnTime = 2000;
long nextSpawnTime = round(random(minSpawnTime, maxSpawnTime));
long nextSpawnTime2 = round(random(minSpawnTime, maxSpawnTime));

float mSize = 30;
boolean canPop = true;
int currFrames = 0;
int framesToPop = 50;
PImage bgImg;
PImage clicker;
String startText = "START";

PFont bubbly;
float bubblyFade = 255;



Minim m;
AudioPlayer handPop;
AudioPlayer manualPop;
AudioPlayer spawnBubs;
AudioPlayer spawnStop;



void setup() {
  frameRate(60);
  size(800, 800);
  noCursor();

  bgImg = loadImage("cloudbg.jpg");
  bgImg.loadPixels();
  clicker = loadImage("bird.jpg");
  clicker.loadPixels();

  m = new Minim(this);
  handPop = m.loadFile("Blop.mp3");
  manualPop = m.loadFile("WaterDrop.mp3");
  spawnBubs = m.loadFile("cancel.mp3");
  spawnStop = m.loadFile("start.mp3");
  bubbly = createFont("bubblebuttacad.ttf", 50);
  textFont(bubbly);
}

void draw() { 
  if (key == ' ' ) {
    spawnBubs.rewind();
    spawnBubs.play();
  } else if (key == 'c') {
    spawnStop.rewind();
    spawnStop.play();
  } else {
    spawnBubs.pause();
    spawnStop.pause();
  }
  image(bgImg, 0, 0);

  if (currFrames >= framesToPop) {
    canPop = true;
    currFrames = 0;
  }
  currFrames++;


  //makes bg lighter
  fill(255, 50);
  rect(-5, -5, width+5, height+5);

  //time spawning of Birds
  if (millis() > nextSpawnTime2) {
    long lower1 = round(minSpawnTime+5000);
    long upper2 = round(maxSpawnTime+5000);
    nextSpawnTime2 = nextSpawnTime2 + round(random(lower1, upper2));
    birds.add(new Bird());
  }
  //time spawning of Bubbles
  if (millis() > nextSpawnTime) {
    long lower = round(minSpawnTime);
    long upper = round(maxSpawnTime);
    nextSpawnTime = nextSpawnTime + round(random(lower, upper));
    if (key == ' ' ) {
      bubbles.add(new Bubble()); //SPAWN BUBBLES
    } else if (key == 'c') {
      bubbles.remove(new Bubble()); // STOPS THE SPAWN
    }
  }

  bubblyText(); //shows text

  for (int i = birds.size()-1; i>=0; i--) { //generate birds
    (birds.get(i)).drawBird();
    (birds.get(i)).move();
  }

  for (int i = bubbles.size()-1; i>=0; i--) { //generate bubbles
    (bubbles.get(i)).drawShape();
    (bubbles.get(i)).move(); 
    //Remove bubbles if it reaches the top or if it is clicked
    if (bubbles.get(i).popTop()) {
      manualPop.rewind();
      manualPop.play();
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

      a1.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x1, y1, toPop.alive);
      a2.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y1, toPop.alive);
      a3.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x1, y1, toPop.alive);
      a4.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y1, toPop.alive);

      bubbles.add(a1);
      bubbles.add(a2);
      bubbles.add(a3);
      bubbles.add(a4);

      if (toPop.alive == false) { //removes splashes 
        bubbles.remove(a1);
        bubbles.remove(a2);
        bubbles.remove(a3);
        bubbles.remove(a4);
      }
    }
  }

  // draw an indicator of where the cursor is
  stroke(0, 0, 255, 50);
  strokeWeight(1);
  //image(clicker,mouseX,mouseY);
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
        handPop.rewind();
        handPop.play();

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


        a1.splashes(toPop.x + random(-1, 1), toPop.y, newSize, x1, y1, toPop.alive);
        a2.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x2, y3, toPop.alive);
        a3.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x3, y2, toPop.alive);
        a4.splashes(toPop.x+ random(-1, 1), toPop.y, newSize, x4, y3, toPop.alive);

        bubbles.add(a1);
        bubbles.add(a2);
        bubbles.add(a3);
        bubbles.add(a4);

        if (toPop.alive == false) { //remove splashes
          bubbles.remove(a1);
          bubbles.remove(a2);
          bubbles.remove(a3);
          bubbles.remove(a4);
        }
      }
    }
  }
}

//adds title and instruction text
void bubblyText() {
  fill(0, 105, 255);
  textSize(30);
  text("Danny Nguyen", 30, 780);
  fill(80, 255, 230+random(-50, 50));
  textSize(100);
  text("BUBBLE GENERATOR", 30, 100);
  fill(255);
  textSize(50);
  //instructions; space to spawn, 'c' to stop.
  if (key == ' ' ) {
    text("Press 'c' to stop bubble spawns.", 95, 135);
  } else if (key == 'c') {
    text("Press 'space' to spawn bubbles.", 95, 135);
  } else {
    textSize(100);
    text("START", 255, 425);
    textSize(50);
    text("Press 'space' to spawn bubbles.", 95, 135);
  }
}