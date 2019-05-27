class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;

  float mass;
  float colR;

  Mover() {
    location = new PVector(400, 50);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    mass = 1;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f); //kasokudo + force
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);//clearing the acceleration each time
  }

  void display() {
    noStroke();
    fill(colR, 40, 80);
    ellipse(location.x, location.y, 16, 16);
    colR++;
    if(colR>255) colR=0;
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}
