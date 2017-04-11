
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

  void setLocation() {
  }
}
















}