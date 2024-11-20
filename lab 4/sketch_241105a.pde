int numFlies = 100;
int numPredators = 3;
Creature[] flies = new Creature[numFlies];
Predator[] predators = new Predator[numPredators];
float evadeDistance = 400;

void setup() {
  size(1600, 1000);
  
  // initialize fireflies
  for (int i = 0; i < numFlies; i++) {
    flies[i] = new Creature(random(width), random(height));
  }
  
  // initialize drones
  for (int i = 0; i < numPredators; i++) {
    predators[i] = new Predator(random(width), random(height));
  }
}

void draw() {
  background(0);
  
  // draw each drone
  for (int i = 0; i < numPredators; i++) {
    predators[i].update();
    predators[i].edges();
    predators[i].display();
  }
  
  // draw each firefly
  for (int i = 0; i < numFlies; i++) {
    flies[i].evade(predators);
    flies[i].update();
    flies[i].edges();
    flies[i].display();
  }
}

// Creature class
class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 10;
  
  Creature(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D().mult(5);
    acceleration = new PVector(0, 0);
  }
  
  void update() {
    PVector randomAccel = PVector.random2D().mult(0.2);
    acceleration.add(randomAccel);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    // draw firefly
    float angle = velocity.heading() + 3*PI/2;
    int numcircles = 7;

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
    fill(178, 160, 120, 150);
    noStroke();
    triangle(-5, 0, -15, -15, -5, -20);
    triangle(5, 0, 15, -15, 5, -20);
    popMatrix();
  }
  
  void edges() {
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }

  void evade(Predator[] predators) {
    for (Predator predator : predators) {
      float distance = PVector.dist(location, predator.location);
      if (distance < evadeDistance) {
        PVector flee = PVector.sub(location, predator.location);
        flee.normalize();
        flee.mult(0.5);
        acceleration.add(flee);
      }
    }
  }
}

// Predator class
class Predator {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 3;
  
  Predator(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
  }
  
  void update() {
    PVector randomAccel = PVector.random2D().mult(0.15);
    acceleration.add(randomAccel);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    float angle = PI/4;
    float gunAngle = velocity.heading();
    float numcircles = 30;
    
    // draw drone
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    
    // propellers
    fill(#8696AF);
    circle(85, 0, 80);
    circle(-85, 0, 80);
    circle(0, 85, 80);
    circle(0, -85, 80);
    
    // drone body
    noStroke();
    for (int i = 0; i < numcircles; i++) {
      fill(#6AA4FF, 0 + i * (80 / numcircles));
      circle(0, 0, 350 - i * (350 / numcircles));
    }
    
    fill(#72699D);
    circle(85, 0, 20);
    circle(-85, 0, 20);
    circle(0, 85, 20);
    circle(0, -85, 20);
    
    rectMode(CENTER);
    fill(#72699D);
    circle(0, 0, 30);
    rect(0, 0, 170, 8);
    rect(0, 0, 8, 170);
    
    popMatrix();
    
    // gun
    pushMatrix();
    translate(location.x, location.y);
    rotate(gunAngle);
    
    rectMode(CENTER);
    fill(#72699D);
    rect(30, 0, 30, 10);
    rect(-10, 0, 25, 20);
    
    // red laser
    if (random(0, 1) > 0.7) {
      fill(255, 0, 0);
      rectMode(CENTER);
      circle(50, 0, 15);
      rect(2550, 0, 5000, 5);
    }
    
    popMatrix();
  }
  
  void edges() {
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }
}
