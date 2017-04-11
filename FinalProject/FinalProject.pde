/*
Danny Nguyen
CRPC 1310
Interactive Bubble Generator

goals : 
- Bubbles appear when you press your spacebar key
- Bubbles rise naturally
- Bubbles bounded by window
- Bubbles popped by users when mousePressed
- Bubbles will fade and show splash effect
- Splash effect will be mini shapes exploding out of bubble
- Bubble pops after a certain period of time
*/
Bubble[] myBubbles = new Bubble[50];
PImage bgImg;

void setup() {
  size(500,500);
  bgImg = loadImage("grassbg.bmp");
  bgImg.loadPixels();
}
void draw() {
  image(bgImg,500,500);

}

void mousePressed() {
}