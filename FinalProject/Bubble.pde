
class Bubble {
  float x=-100;
  float y=-100;
  float aSize = 80;
  float xSpeed = 0;
  float ySpeed = 0;
  boolean alive = true; //life span
  color c;
  float clearBubs = 0;
  
  Bubble() {
    x = random(0+aSize,width-aSize); //Bubbles spawns from anywhere on vertically  
    y = height + aSize;
    aSize = random(50,100);
    xSpeed = random(-0.2,0.2);
    ySpeed = random(-0.9,-1.0);
    c = color(random(70,100),random(150,200),random(220,255));
    clearBubs = 100;
    //random(50,100);
  }
  
  void splashes(float x, float y, float newSize, float xSpeed, float ySpeed, boolean Alive) {
    this.x = x;
    this.y = y;
    this.aSize = newSize;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.alive = Alive;
  }
  
  void drawShape() {
    //rectMode(CENTER);
    //blendMode();
    rect(x-aSize/2+random(-0.5,0.5),y-aSize/2+random(-0.5,0.5),aSize,aSize,50);
    fill(255,clearBubs);
    ellipse(x,y,aSize,aSize);
    fill(c,clearBubs);
    stroke(255,clearBubs);
    ellipse(x,y,aSize,aSize);
    fill(255,clearBubs);
    ellipse(x+random(-0.8,0.8)+aSize/4, y+random(-0.8,0.8)+aSize/4, aSize/10,aSize/10);
    if (aSize < 10) {
      clearBubs -= 0.5;
    } if (clearBubs == 0) {
      alive = false;
    }
  }
  
  void move() {
    x = x + xSpeed;
    y = y + ySpeed;
    if (x <= aSize) {
      alive = false;
    }
  }
  
  boolean isPopped() {
    return (mouseY <= y + aSize/2 && mouseY >= y - aSize/2 && mouseX <= x+aSize/2 && mouseX >= x-aSize/2);
 }
 
 boolean popTop() {
   return ( y < aSize/2);
 }
}