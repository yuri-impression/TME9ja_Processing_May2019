class Mover {

  //each PVector contains (x,y)coordinate
  PVector location; 
  PVector velocity;

  //constructor (just called once when class got instantiated)
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
  }

  void update() {
    location.add(velocity); //just like we added speed to position in 1_2
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 48, 48);
  }

  //checking the location of the ball 
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
