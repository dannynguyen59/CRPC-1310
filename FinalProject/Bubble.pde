
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
    x = width/2; //Bubbles come from middle  
    y = height + aSize;
    aSize = random(10,80);
    xSpeed = random(-0.2,0.2);
    ySpeed = random(-0.9,-1.0);
    c = color(random(100,150),random(100,150),random(200,255));
    clearBubs = 80;
    //random(50,100);
  }
  
  void splashes(float x, float y, float newSize, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.aSize = newSize;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  
  void drawShape() {
    fill(c,clearBubs);
    noStroke();
    ellipse(x,y,aSize,aSize);
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
    return (mouseY <= y + aSize && mouseY >= y - aSize && mouseX <= x+aSize && mouseX >= x-aSize);
 }
 
 boolean popTop() {
   return ( y < aSize/2);
 }
}