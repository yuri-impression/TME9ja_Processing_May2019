//Reference: The Nature of Code by Daniel Shiffman

//call 20 movers
Mover[] movers = new Mover[20];

void setup() {
  size(640, 360);
  //instantiate 20 movers
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  //background(255);
  noStroke();
  fill(255, 40);
  rect(0, 0, width, height);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}
