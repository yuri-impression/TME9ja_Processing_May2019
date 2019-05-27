class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float colR, colG, colB;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    topspeed = 10;
    //randomizing color
    colR=random(255);
    colG=random(255);
    colB=random(255);
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    
    dir.normalize();
    dir.mult(0.5);
    
    acceleration = dir;

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(1);
    fill(colR, colG, colB);
    ellipse(location.x, location.y, 48, 48);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
