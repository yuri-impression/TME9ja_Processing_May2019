float xpos = 0;
float ypos = 0;
float xspeed = 8;
float yspeed = 6;
float radius = 30;

void setup () {
  size(200, 200);
  frameRate(30);
  noStroke(); //stop drawing border line of each object
  smooth();
}

void draw () {
  //to leave a trace, draw a background with a little bit transparency.
  fill(255, 40);
  rect(0, 0, width, height);
  
  fill(100, 40, 200, 70);
  ellipse(xpos, ypos, radius, radius);
  xpos = xpos + xspeed;
  ypos = ypos + yspeed;
  if (xpos > width|| xpos < 0) {
    xspeed = xspeed * -1;
  }
  if (ypos > height || ypos < 0) {
    yspeed = yspeed * -1;
  }
}
