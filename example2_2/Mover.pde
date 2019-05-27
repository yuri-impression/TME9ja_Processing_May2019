class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration; //
  float topspeed;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    topspeed = 10;
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    //create a PVector which shows the vector of movement to mouseX/Y
    PVector dir = PVector.sub(mouse, location); 
    
    //Normalize the vector to the mouseX/Y to prevent overspeeding
    dir.normalize();
    dir.mult(0.8);
    
    //use it as acceleration
    acceleration = dir;

    velocity.add(acceleration); //speed + acceleration
    velocity.limit(topspeed); //limit the speed(velocity)
    location.add(velocity);
  }

  void display() {
    stroke(1);
    fill(175);
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
