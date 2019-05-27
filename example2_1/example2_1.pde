//Reference: The Nature of Code by Daniel Shiffman

Mover mover; //call the class

void setup() {
  size(640, 360);
  mover = new Mover(); //instantiation (constructor is called)
}

void draw() {
  //background(255);
  fill(255, 40);
  noStroke();
  rect(0, 0, width, height);
  
  //OOP style
  mover.update();
  mover.checkEdges();
  mover.display();
}
