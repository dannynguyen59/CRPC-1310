
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
    x = mouseX; //Bubbles come from middle  
    y = height + aSize;
    aSize = random(50,100);
    xSpeed = random(-0.2,0.2);
    ySpeed = random(-0.9,-1.0);
    c = color(random(70,100),random(150,200),random(220,255));
    clearBubs = 150;
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
    
    fill(255,clearBubs);
    ellipse(x,y,aSize,aSize);
    fill(c,clearBubs);
    stroke(255,clearBubs);
    ellipse(x,y,aSize,aSize);
    pushMatrix();
    translate(x,y);
    rotate(0.1);
    fill(255,clearBubs);
    ellipse(x+random(-0.8,0.8)+aSize/4, y+random(-0.8,0.8)+aSize/4, aSize/10,aSize/10);
    popMatrix();
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