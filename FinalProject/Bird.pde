class Bird {
  PImage img;
  PImage img2;
  float x = 0;
  float y = 0;
  float w = 0;
  float h = 0;
  float w2= 0;
  float h2= 0;
  float xSpeed = 0;
  float ySpeed = 0;
  boolean alive = true; //life span

  long flapTime = 0;
  long flapTime2 = 2000;
  long nextFlapTime = 2000;

  //LINE 19-20 CODE FOUND ON PROCESSING FORUM "how to reset count time", USER: csteinlehner
  int lastTime = 0;
  int m = 0;


  Bird() {
    img = flip(loadImage("1a.png"));
    img2= flip(loadImage("2a.png"));
    x = -100;
    y = random(0, height);
    xSpeed = random(2, 5);
    ySpeed = random(-0.2, 0.2);
    w = img.width;
    h = img.height;
    w2 = img2.width;
    h2 = img2.height;
  }

  void drawBird() {
    //LINE 38-40 CODE FOUND ON PROCESSING FORUM "how to reset count time", USER: csteinlehner
    m = millis() - lastTime;
    if (millis()> lastTime + 4000) {
      lastTime = millis();
    } 

    if (m > 0 && m < 1000 || m > 2000 && m < 3000) {
      image(img, x, y);  
      img.resize(100, 100);
    } 
    if (m > 1000 && m < 2000|| m > 3000 && m < 4000) {
      image(img2, x, y); 
      img2.resize(100, 100);
    }

    //println(m); check milliseconds
  }

  void move() {
    x = x + xSpeed;
    y = y + ySpeed;
    if (x > width + img.width || x > width + img2.width) {
      alive = false;
    }
  }

  PImage flip(PImage orig) {
    PImage newImg = createImage(orig.width, orig.height, ARGB);
    for (int i=0; i<orig.height; i++) { // for each row... (y axis)
      for (int j=0; j<orig.width; j++) { // for each column... (x axis)
        newImg.set(orig.width-1-j, i, orig.get(j, i));
      }
    }
    return newImg;
  }
}