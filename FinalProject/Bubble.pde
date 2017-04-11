
class Bubble {
  float x;
  float y;
  float d;
  float xSpeed;
  float ySpeed;
  float xAccel;
  float yAccel;
  int transparency;
  int transparencyChange;
  boolean bubblePopped = false;

  Bubble(float newX, float newY, float newSize) {
    x = newX;
    y = newY;
    d = newSize;
  }

  void newBubble() {
  }

  void popBubble() { //inspired by "LightsOut" fade
    bubblePopped = !bubblePopped;
    if (bubblePopped) {
      transparency = transparencyChange;
    } else {
      transparency = -transparencyChange;
    }
  }

  void bubbleTransparency() {
  }

  void bubbleFloats() { //inspired by doodle_bug movement
    x = x + xSpeed;
    y = y + ySpeed;
    xSpeed = min(max(xSpeed + random(-3, 3), -3), 3);
    ySpeed = min(max(ySpeed + random(-3, 3), -3), 3);
    if ( x <=0 && xSpeed < 0 || x > width-d && xSpeed > 0) {
      xSpeed = -xSpeed;
    }
    if ( y <=0 && ySpeed < 0 || y > height-d && ySpeed > 0) {
      ySpeed = -ySpeed;
    }
  }
}