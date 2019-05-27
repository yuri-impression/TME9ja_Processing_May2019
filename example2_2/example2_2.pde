//Reference: The Nature of Code by Daniel Shiffman
Mover mover;

void setup() {
  size(640, 360);
  mover = new Mover();
}

void draw() {
  //background(255);
  noStroke();
  fill(255, 40);
  rect(0, 0, width, height);
  
  mover.update();
  mover.checkEdges();
  mover.display();
}
