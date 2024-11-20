int numFlies = 75;
Creature[] flies = new Creature[numFlies];

void setup() {
  size(1600, 1000);
  for (int i = 0; i < numFlies; i++) {
    flies[i] = new Creature(random(width), random(height));
  }
}

void draw() {
  background(0);
  
  // draw each firefly
  for (int i = 0; i < numFlies; i++) {
    flies[i].update();
    flies[i].edges();
    flies[i].display();
  }
}

// creature class
class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 5;
  
  // constructor
  Creature(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }
  
  // method to update movement
  void update() {
    PVector randomAccel = PVector.random2D().mult(0.2);
    acceleration.add(randomAccel);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  // method to draw firefly
  void display() {
    // movement angle
    float angle = velocity.heading() + 3*PI/2;
    int numcircles = 10;

    // draw the firefly
    pushMatrix();
    translate(location.x, location.y);
    
    noStroke();
    for (int i = 0; i < numcircles; i++) {
      fill(237, 198, 0, 0 + i * (80 / numcircles));
      circle(0, 0, 80 - i * (80 / numcircles));
    }

    popMatrix();
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    
    stroke(240, 200, 5);
    fill(240, 200, 5);
    ellipse(0, 0, 10, 20);

    stroke(0);
    fill(0);
    ellipse(0, 5, 10, 13);

    // wings
    fill(178, 160, 120, 150);
    noStroke();
    triangle(-5, 0, -15, -15, -5, -20);
    triangle(5, 0, 15, -15, 5, -20);
    
    popMatrix();
  }
  
  // method to reset position
  void edges() {
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }
}
