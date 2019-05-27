float xpos = 0;
float ypos = 0;
//xspeed and yspeed is the value (px) of movement of the circle at every fram
float xspeed = 8;
float yspeed = 6;

void setup () {
  size(200, 200);
  frameRate(30); //frameRate is 30frame/1sec
  fill(100, 40, 200, 70); 
  //Syntax of fill();
  //1. fill(g) -> greyscale (0-255)
  //2. fill(g, alpha) -> greyscale + alphaValue(transparency) (0-255)
  //3. fill(R, G, B); -> RGB (HSB if you use colorMode(HSB); in void setup) (0-255)
  //4. fill(R, G, B, alpha) -> RGB+alphaValue (0-255)
  smooth(); //anti-aliasing
}
void draw () {
  background(255);
  //redraw background(white) at every frame to prevent that results of every frame remain
  ellipse(xpos, ypos, 30, 30);
  //speeds are added to xpos and ypos 
  xpos = xpos + xspeed;
  ypos = ypos + yspeed;
  //bouncing
  if (xpos > 200 || xpos < 0) {
    xspeed = xspeed * -1;
  }
  if (ypos > 200 || ypos < 0) {
    yspeed = yspeed * -1;
  }
}
