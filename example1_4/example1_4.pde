float xpos = 100.0;
float ypos = 100.0;
float radius = 15.0;
float speedX = 8.0;
float speedY = 6.4;
int directionX = 1;
int directionY = -1;
float racket = 250;

void setup() {
  size(500, 500);
  smooth();
  noStroke();
  ellipseMode(RADIUS);
  frameRate(60);
}

void draw() {
  fill(255, 220);
  rect(0, 0, width, height);
  fill(100);
  ellipse(xpos, ypos, radius, radius);

  xpos += speedX * directionX;
  if ((xpos > width-radius) || (xpos < radius)) {
    directionX = -directionX;
  }

  ypos += speedY * directionY;

  if ((ypos > height-radius) || (ypos < radius)) {
    directionY = -directionY;
  }

  rect (racket, 450, 100, 10);//drawing racket
  if (keyPressed) {
    if (keyCode == RIGHT) { //keycode may vary
      racket = racket + 20;
      if (racket>width-100)racket = width-100;
    }
    if (keyCode == LEFT) {
      racket = racket - 20;
      if (racket<0)racket = 0;
    }
  }
  //racket bouncing
  if ((racket < xpos) && (racket+100 > xpos) && (ypos < 450) && (ypos > 440) ) {
    directionY = -directionY;
  }
  
  //increase speed at each frame
  speedX+=0.001;
  speedY+=0.001;
}
