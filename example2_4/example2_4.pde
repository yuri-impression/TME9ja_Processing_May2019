//Reference: The Nature of Code by Daniel Shiffman

Mover m;
Attractor a;

void setup(){
  size(640, 360);
  background(255);
  smooth();
  frameRate(60);
  m = new Mover();
  a = new Attractor();
}

void draw(){
  //background(255);
  /*noStroke();
  fill(255, 40);
  rect(0,0, width, height);
  */
  PVector force = a.attract(m);
  m.applyForce(force);
  m.update();
  
  a.display();
  m.display();
}
